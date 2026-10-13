
import pandas as pd
import numpy as np
from pathlib import Path

# ============================================================
# NOVA RETAIL ANALYTICS
# Large synthetic dataset for SQL data-quality practice
# This script creates ONE set of anomalous CSV files.
# It does NOT clean or repair the data.
# ============================================================

SEED = 42
rng = np.random.default_rng(SEED)

OUTPUT_DIR = Path(__file__).resolve().parent / "nova_retail_data"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

N_CITIES = 12
N_CUSTOMERS = 5_000
N_PRODUCTS = 500
N_ORDERS = 25_000
N_ORDER_ITEMS = 50_000
N_PAYMENTS = 25_000
N_RETURNS = 2_500


def random_dates(start, end, count):
    days = pd.date_range(start=start, end=end, freq="D")
    chosen = rng.integers(0, len(days), size=count)
    return days[chosen].strftime("%Y-%m-%d")


def export_csv(name, df):
    path = OUTPUT_DIR / f"{name}.csv"
    df.to_csv(path, index=False, na_rep="")
    print(f"Created {name}.csv: {len(df):,} rows")


# ============================================================
# 1. CITIES
# ============================================================

cities = pd.DataFrame({
    "city_id": range(1, N_CITIES + 1),
    "city_name": [
        "Delhi", "Gurugram", "Noida", "Mumbai",
        "Pune", "Jaipur", "Kolkata", "Bengaluru",
        "Hyderabad", "Chennai", "Lucknow", "Ahmedabad"
    ],
    "state_name": [
        "Delhi", "Haryana", "Uttar Pradesh", "Maharashtra",
        "Maharashtra", "Rajasthan", "West Bengal", "Karnataka",
        "Telangana", "Tamil Nadu", "Uttar Pradesh", "Gujarat"
    ],
    "region": [
        "North", "North", "North", "West",
        "West", "North", "East", "South",
        "South", "South", "North", "West"
    ]
})


# ============================================================
# 2. CUSTOMERS
# ============================================================

customer_ids = np.arange(100001, 100001 + N_CUSTOMERS)

customers = pd.DataFrame({
    "customer_id": customer_ids,
    "customer_name": [
        f"Customer_{i:05d}" for i in range(1, N_CUSTOMERS + 1)
    ],
    "gender": rng.choice(
        ["Male", "Female", "Other"], N_CUSTOMERS,
        p=[0.48, 0.49, 0.03]
    ),
    "age": rng.integers(18, 71, N_CUSTOMERS),
    "city_id": rng.choice(cities["city_id"], N_CUSTOMERS),
    "signup_date": random_dates(
        "2022-01-01", "2026-12-31", N_CUSTOMERS
    )
})


# ============================================================
# 3. PRODUCTS
# ============================================================

categories = {
    "Electronics": ["Laptops", "Mobiles", "Tablets", "Accessories"],
    "Home": ["Furniture", "Lighting", "Kitchen", "Decor"],
    "Fashion": ["Clothing", "Footwear", "Bags", "Watches"],
    "Lifestyle": ["Fitness", "Stationery", "Travel", "Personal Care"]
}

product_categories = rng.choice(list(categories), N_PRODUCTS)
unit_cost = rng.uniform(100, 20000, N_PRODUCTS).round(2)

products = pd.DataFrame({
    "product_id": np.arange(200001, 200001 + N_PRODUCTS),
    "product_name": [
        f"Product_{i:04d}" for i in range(1, N_PRODUCTS + 1)
    ],
    "category": product_categories,
    "sub_category": [
        rng.choice(categories[category])
        for category in product_categories
    ],
    "unit_cost": unit_cost,
    "selling_price": (
        unit_cost * rng.uniform(1.10, 1.80, N_PRODUCTS)
    ).round(2)
})


# ============================================================
# 4. ORDERS
# ============================================================

order_ids = np.arange(300001, 300001 + N_ORDERS)

orders = pd.DataFrame({
    "order_id": order_ids,
    "customer_id": rng.choice(customer_ids, N_ORDERS),
    "order_date": random_dates(
        "2024-01-01", "2026-12-31", N_ORDERS
    ),
    "city_id": rng.choice(cities["city_id"], N_ORDERS),
    "order_status": rng.choice(
        ["Delivered", "Shipped", "Processing", "Cancelled"],
        N_ORDERS,
        p=[0.60, 0.18, 0.12, 0.10]
    )
})


# ============================================================
# 5. ORDER ITEMS
# ============================================================

order_items = pd.DataFrame({
    "order_item_id": np.arange(
        500001, 500001 + N_ORDER_ITEMS
    ),
    "order_id": rng.choice(order_ids, N_ORDER_ITEMS),
    "product_id": rng.choice(
        products["product_id"].to_numpy(), N_ORDER_ITEMS
    ),
    "quantity": rng.integers(1, 6, N_ORDER_ITEMS),
    "discount_percent": rng.choice(
        [0, 5, 10, 15, 20, 25], N_ORDER_ITEMS
    ).astype(float)
})


# ============================================================
# 6. PAYMENTS
# ============================================================

payments = pd.DataFrame({
    "payment_id": np.arange(700001, 700001 + N_PAYMENTS),
    "order_id": order_ids.copy(),
    "payment_date": orders["order_date"].to_numpy(),
    "payment_method": rng.choice(
        ["UPI", "Credit Card", "Debit Card", "Cash", "Net Banking"],
        N_PAYMENTS
    ),
    "payment_status": rng.choice(
        ["Paid", "Pending", "Failed"],
        N_PAYMENTS,
        p=[0.82, 0.10, 0.08]
    ),
    "amount": rng.uniform(200, 50000, N_PAYMENTS).round(2)
})


# ============================================================
# 7. RETURNS
# ============================================================

return_sample = order_items.sample(
    n=N_RETURNS, random_state=SEED
).copy()

returns = pd.DataFrame({
    "return_id": np.arange(900001, 900001 + N_RETURNS),
    "order_item_id": return_sample["order_item_id"].to_numpy(),
    "return_date": random_dates(
        "2024-01-01", "2026-12-31", N_RETURNS
    ),
    "return_reason": rng.choice(
        ["Damaged", "Wrong Item", "Late Delivery",
         "Not Required", "Quality Issue"],
        N_RETURNS
    ),
    "return_quantity": [
        rng.integers(1, int(quantity) + 1)
        for quantity in return_sample["quantity"]
    ]
})


# ============================================================
# 8. INTRODUCE INTENTIONAL ANOMALIES
# The raw records remain uncleaned.
# ============================================================

# CUSTOMERS:
# Duplicate customer_id; missing customer name
customers.loc[1, "customer_id"] = customers.loc[0, "customer_id"]
customers.loc[2, "customer_name"] = None

# ORDERS:
# Nonexistent customer ID; NULL customer ID
orders.loc[0, "customer_id"] = 999999
orders.loc[1, "customer_id"] = np.nan

# PRODUCTS:
# Duplicate product_id; negative selling price
products.loc[1, "product_id"] = products.loc[0, "product_id"]
products.loc[2, "selling_price"] = -500.00

# ORDER_ITEMS:
# Nonexistent product ID; NULL product ID; duplicate item ID
order_items.loc[0, "product_id"] = 999999
order_items.loc[1, "product_id"] = np.nan
order_items.loc[2, "order_item_id"] = order_items.loc[0, "order_item_id"]

# PAYMENTS:
# Nonexistent order ID; NULL order ID; duplicate payment ID
payments.loc[0, "order_id"] = 999999
payments.loc[1, "order_id"] = np.nan
payments.loc[2, "payment_id"] = payments.loc[0, "payment_id"]

# RETURNS:
# Nonexistent item ID; NULL item ID; duplicate return ID;
# excessive return quantity
returns.loc[0, "order_item_id"] = 999999
returns.loc[1, "order_item_id"] = np.nan
returns.loc[2, "return_id"] = returns.loc[0, "return_id"]
returns.loc[3, "return_quantity"] = 999


# ============================================================
# 9. EXPORT THE ONLY SET OF CSV FILES
# No second folder. No automatic cleaning.
# Nullable IDs use pandas' nullable integer type so blank IDs
# export as empty CSV fields instead of decimal values.
# ============================================================

tables = {
    "cities": cities,
    "customers": customers,
    "products": products,
    "orders": orders,
    "order_items": order_items,
    "payments": payments,
    "returns": returns
}

integer_columns = {
    "cities": ["city_id"],
    "customers": ["customer_id", "city_id", "age"],
    "products": ["product_id"],
    "orders": ["order_id", "customer_id", "city_id"],
    "order_items": [
        "order_item_id", "order_id", "product_id", "quantity"
    ],
    "payments": ["payment_id", "order_id"],
    "returns": ["return_id", "order_item_id", "return_quantity"]
}

for table_name, columns in integer_columns.items():
    for column in columns:
        tables[table_name][column] = (
            tables[table_name][column].astype("Int64")
        )

print("\nGENERATING CSV FILES WITH ANOMALIES\n")

for table_name, dataframe in tables.items():
    export_csv(table_name, dataframe)


# ============================================================
# 10. SUMMARY
# ============================================================

print("\n" + "=" * 60)
print("NOVA RETAIL DATASET GENERATED")
print("=" * 60)

for table_name, dataframe in tables.items():
    print(f"{table_name:<15} {len(dataframe):>10,} rows")

print("\nDataset folder:")
print(OUTPUT_DIR.resolve())

print("\nSeven CSV files generated.")
print("Anomalies have NOT been cleaned.")
print("Next: import into MySQL staging tables.")
