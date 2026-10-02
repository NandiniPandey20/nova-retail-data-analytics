# ============================================================
# NOVA RETAIL ANALYTICS
# Synthetic Business Dataset Generator
# ============================================================

import pandas as pd
import numpy as np
from pathlib import Path

# ------------------------------------------------------------
# 1. SETTINGS
# ------------------------------------------------------------

SEED = 42
rng = np.random.default_rng(SEED)

# Number of records
NUM_CUSTOMERS = 5000
NUM_ORDERS = 25000

# Date range for the business
START_DATE = "2024-01-01"
END_DATE = "2026-12-31"

# Folder where CSV files will be saved
OUTPUT_FOLDER = Path("nova_retail_data")
OUTPUT_FOLDER.mkdir(exist_ok=True)


# ============================================================
# 2. CITIES TABLE
# ============================================================

cities = pd.DataFrame({
    "city_id": range(1, 13),

    "city_name": [
        "Delhi",
        "Mumbai",
        "Bengaluru",
        "Hyderabad",
        "Chennai",
        "Kolkata",
        "Pune",
        "Ahmedabad",
        "Jaipur",
        "Lucknow",
        "Gurugram",
        "Noida"
    ],

    "state_name": [
        "Delhi",
        "Maharashtra",
        "Karnataka",
        "Telangana",
        "Tamil Nadu",
        "West Bengal",
        "Maharashtra",
        "Gujarat",
        "Rajasthan",
        "Uttar Pradesh",
        "Haryana",
        "Uttar Pradesh"
    ],

    "region": [
        "North",
        "West",
        "South",
        "South",
        "South",
        "East",
        "West",
        "West",
        "North",
        "North",
        "North",
        "North"
    ]
})


# ============================================================
# 3. PRODUCTS TABLE
# ============================================================

product_categories = {
    "Electronics": {
        "sub_categories": [
            "Smartphone",
            "Laptop",
            "Tablet",
            "Headphones",
            "Smartwatch"
        ],
        "price_range": (800, 90000),
        "margin_range": (0.12, 0.28),
        "return_rate": 0.06
    },

    "Home Appliances": {
        "sub_categories": [
            "Air Conditioner",
            "Refrigerator",
            "Microwave",
            "Washing Machine",
            "Mixer"
        ],
        "price_range": (1500, 70000),
        "margin_range": (0.10, 0.22),
        "return_rate": 0.08
    },

    "Fashion": {
        "sub_categories": [
            "Men Clothing",
            "Women Clothing",
            "Footwear",
            "Bags",
            "Accessories"
        ],
        "price_range": (300, 12000),
        "margin_range": (0.25, 0.55),
        "return_rate": 0.18
    },

    "Personal Care": {
        "sub_categories": [
            "Skincare",
            "Haircare",
            "Grooming",
            "Fragrance",
            "Beauty"
        ],
        "price_range": (150, 8000),
        "margin_range": (0.25, 0.50),
        "return_rate": 0.10
    },

    "Home & Living": {
        "sub_categories": [
            "Furniture",
            "Kitchenware",
            "Bedding",
            "Decor",
            "Storage"
        ],
        "price_range": (300, 40000),
        "margin_range": (0.18, 0.40),
        "return_rate": 0.08
    },

    "Accessories": {
        "sub_categories": [
            "Cables",
            "Chargers",
            "Cases",
            "Computer Accessories",
            "Mobile Accessories"
        ],
        "price_range": (100, 10000),
        "margin_range": (0.15, 0.45),
        "return_rate": 0.07
    }
}


products_data = []

product_id = 1

for category, details in product_categories.items():

    for sub_category in details["sub_categories"]:

        # 5 products for each sub-category
        for i in range(1, 6):

            min_price, max_price = details["price_range"]

            selling_price = rng.integers(
                min_price,
                max_price + 1
            )

            min_margin, max_margin = details["margin_range"]

            margin = rng.uniform(
                min_margin,
                max_margin
            )

            unit_cost = selling_price * (1 - margin)

            products_data.append([
                product_id,
                f"{sub_category} {i}",
                category,
                sub_category,
                round(unit_cost, 2),
                round(float(selling_price), 2)
            ])

            product_id += 1


products = pd.DataFrame(
    products_data,
    columns=[
        "product_id",
        "product_name",
        "category",
        "sub_category",
        "unit_cost",
        "selling_price"
    ]
)


# ============================================================
# 4. CUSTOMERS TABLE
# ============================================================

first_names = [
    "Aarav", "Aditi", "Arjun", "Ananya", "Aditya",
    "Diya", "Rohan", "Priya", "Rahul", "Isha",
    "Karan", "Meera", "Vikram", "Sneha", "Neha",
    "Riya", "Kabir", "Nisha", "Varun", "Pooja"
]

last_names = [
    "Sharma", "Verma", "Gupta", "Singh", "Patel",
    "Mehta", "Kumar", "Joshi", "Malhotra", "Kapoor",
    "Chopra", "Agarwal", "Pandey", "Mishra", "Shah"
]

customer_names = [
    f"{rng.choice(first_names)} {rng.choice(last_names)}"
    for _ in range(NUM_CUSTOMERS)
]

customers = pd.DataFrame({
    "customer_id": range(1, NUM_CUSTOMERS + 1),

    "customer_name": customer_names,

    "gender": rng.choice(
        ["Male", "Female", "Other"],
        size=NUM_CUSTOMERS,
        p=[0.48, 0.49, 0.03]
    ),

    # 18 to 50 inclusive
    "age": rng.integers(
        18,
        51,
        NUM_CUSTOMERS
    ),

    # Customers distributed across cities
    "city_id": rng.choice(
        cities["city_id"],
        size=NUM_CUSTOMERS,
        p=[
            0.12,  # Delhi
            0.11,  # Mumbai
            0.11,  # Bengaluru
            0.08,  # Hyderabad
            0.08,  # Chennai
            0.07,  # Kolkata
            0.08,  # Pune
            0.07,  # Ahmedabad
            0.06,  # Jaipur
            0.06,  # Lucknow
            0.08,  # Gurugram
            0.08   # Noida
        ]
    ),

    "signup_date": pd.to_datetime(
        rng.choice(
            pd.date_range(
                "2023-01-01",
                "2026-06-30"
            ),
            size=NUM_CUSTOMERS
        )
    )
})


# ============================================================
# 5. ORDERS TABLE
# ============================================================

# Customers don't all order equally.
# Some customers are much more active than others.

customer_order_weights = rng.gamma(
    shape=1.8,
    scale=1.0,
    size=NUM_CUSTOMERS
)

customer_order_weights = (
    customer_order_weights /
    customer_order_weights.sum()
)

selected_customers = rng.choice(
    customers["customer_id"],
    size=NUM_ORDERS,
    p=customer_order_weights
)

# Convert customer IDs to their cities
customer_city_map = customers.set_index(
    "customer_id"
)["city_id"]

order_cities = [
    customer_city_map[customer_id]
    for customer_id in selected_customers
]


# Generate random order dates
order_dates = pd.to_datetime(
    rng.choice(
        pd.date_range(
            START_DATE,
            END_DATE
        ),
        size=NUM_ORDERS
    )
)

# Order status
order_statuses = rng.choice(
    [
        "Completed",
        "Completed",
        "Completed",
        "Completed",
        "Cancelled"
    ],
    size=NUM_ORDERS
)

orders = pd.DataFrame({
    "order_id": range(1, NUM_ORDERS + 1),

    "customer_id": selected_customers,

    "order_date": order_dates,

    "city_id": order_cities,

    "order_status": order_statuses
})

# Sort by date
orders = orders.sort_values(
    "order_date"
).reset_index(drop=True)


# ============================================================
# 6. ORDER ITEMS TABLE
# ============================================================

order_items_data = []

order_item_id = 1

# Product popularity
# Some products naturally sell more than others
product_weights = rng.gamma(
    shape=1.5,
    scale=1.0,
    size=len(products)
)

product_weights = (
    product_weights /
    product_weights.sum()
)


for _, order in orders.iterrows():

    # Number of different products in an order
    number_of_items = rng.choice(
        [1, 2, 3, 4],
        p=[0.55, 0.28, 0.12, 0.05]
    )

    selected_products = rng.choice(
        products["product_id"],
        size=number_of_items,
        replace=False,
        p=product_weights
    )

    for product_id in selected_products:

        # Quantity
        quantity = rng.choice(
            [1, 2, 3, 4],
            p=[0.65, 0.23, 0.09, 0.03]
        )

        # Discount
        discount = rng.choice(
            [0, 5, 10, 15, 20, 25, 30],
            p=[
                0.22,
                0.18,
                0.20,
                0.16,
                0.12,
                0.08,
                0.04
            ]
        )

        order_items_data.append([
            order_item_id,
            order["order_id"],
            product_id,
            quantity,
            discount
        ])

        order_item_id += 1


order_items = pd.DataFrame(
    order_items_data,
    columns=[
        "order_item_id",
        "order_id",
        "product_id",
        "quantity",
        "discount_percent"
    ]
)


# ============================================================
# 7. PAYMENTS TABLE
# ============================================================

# Calculate order totals first

order_items_calculation = order_items.merge(
    products[
        [
            "product_id",
            "selling_price"
        ]
    ],
    on="product_id",
    how="left"
)

order_items_calculation["item_revenue"] = (
    order_items_calculation["selling_price"]
    *
    order_items_calculation["quantity"]
    *
    (
        1 -
        order_items_calculation["discount_percent"] / 100
    )
)

order_totals = (
    order_items_calculation
    .groupby("order_id")["item_revenue"]
    .sum()
)


# Payments only for completed orders
completed_orders = orders[
    orders["order_status"] == "Completed"
].copy()

completed_orders["amount"] = (
    completed_orders["order_id"]
    .map(order_totals)
    .fillna(0)
)


payments = pd.DataFrame({
    "payment_id": range(
        1,
        len(completed_orders) + 1
    ),

    "order_id": completed_orders[
        "order_id"
    ].values,

    "payment_date": completed_orders[
        "order_date"
    ].values,

    "payment_method": rng.choice(
        [
            "UPI",
            "Credit Card",
            "Debit Card",
            "Net Banking",
            "Cash on Delivery"
        ],
        size=len(completed_orders),
        p=[
            0.40,
            0.22,
            0.15,
            0.08,
            0.15
        ]
    ),

    "payment_status": "Paid",

    "amount": completed_orders[
        "amount"
    ].round(2).values
})


# ============================================================
# 8. RETURNS TABLE
# ============================================================

# Merge order status and product information
return_candidates = (
    order_items
    .merge(
        orders[
            [
                "order_id",
                "order_date",
                "order_status"
            ]
        ],
        on="order_id",
        how="left"
    )
    .merge(
        products[
            [
                "product_id",
                "category"
            ]
        ],
        on="product_id",
        how="left"
    )
)

# Only completed orders can be returned
return_candidates = return_candidates[
    return_candidates["order_status"] == "Completed"
].copy()


# Base return probabilities by category
return_probability = {
    "Electronics": 0.06,
    "Home Appliances": 0.08,
    "Fashion": 0.18,
    "Personal Care": 0.10,
    "Home & Living": 0.08,
    "Accessories": 0.07
}

return_candidates["return_probability"] = (
    return_candidates["category"]
    .map(return_probability)
)


# Randomly determine which order items are returned
return_candidates["is_returned"] = (
    rng.random(len(return_candidates))
    <
    return_candidates["return_probability"]
)


returned_items = return_candidates[
    return_candidates["is_returned"]
].copy()


return_reasons = [
    "Product damaged",
    "Wrong product",
    "Size issue",
    "Changed mind",
    "Product not as expected",
    "Defective product"
]


returns = pd.DataFrame({
    "return_id": range(
        1,
        len(returned_items) + 1
    ),

    "order_item_id": returned_items[
        "order_item_id"
    ].values,

    "return_date": (
        returned_items["order_date"]
        +
        pd.to_timedelta(
            rng.integers(
                2,
                31,
                len(returned_items)
            ),
            unit="D"
        )
    ).values,

    "return_reason": rng.choice(
        return_reasons,
        size=len(returned_items)
    ),

    "return_quantity": [
        rng.integers(
            1,
            quantity + 1
        )
        for quantity in returned_items["quantity"]
    ]
})


# ============================================================
# 9. SAVE ALL TABLES AS CSV
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


for table_name, dataframe in tables.items():

    file_path = OUTPUT_FOLDER / f"{table_name}.csv"

    dataframe.to_csv(
        file_path,
        index=False
    )

    print(
        f"{table_name:15} → "
        f"{len(dataframe):,} rows → "
        f"{file_path}"
    )


# ============================================================
# 10. FINAL SUMMARY
# ============================================================

print("\n============================================")
print("NOVA RETAIL DATASET GENERATED SUCCESSFULLY")
print("============================================")

for table_name, dataframe in tables.items():

    print(
        f"{table_name:15}: "
        f"{len(dataframe):,} rows"
    )

print("\nFiles saved inside:")
print(OUTPUT_FOLDER.resolve())