USE nova_retail_analytics;

-- Q56. Record the cleaning rules applied to each issue.

CREATE TABLE cleaning_log (
    issue_name VARCHAR(100),
    cleaning_rule VARCHAR(500)
);

INSERT INTO cleaning_log VALUES
('Duplicate primary keys',
 'Identify duplicate IDs and investigate before retaining or excluding records.'),

('Missing required values',
 'Recover values only when reliable source information is available; otherwise exclude or flag records.'),

('Invalid foreign keys',
 'Exclude or quarantine records referencing nonexistent parent IDs.'),

('Invalid prices',
 'Investigate negative or zero prices before excluding invalid records.'),

('Invalid quantities',
 'Exclude or investigate zero and negative quantities.'),

('Invalid discounts',
 'Retain only discounts between 0 and 100 percent.'),

('Multiple payments',
 'Investigate payment status and transaction details before deciding whether payments are valid.'),

('Unresolved values',
 'Do not invent or randomly replace missing values.');


-- View the cleaning rules.

SELECT * FROM cleaning_log;


-- Q57. Compare row counts before and after cleaning.

-- This query records the original row counts.
-- Run it again after creating your cleaned tables to compare.

SELECT 'cities' AS table_name, COUNT(*) AS original_records
FROM stage_cities

UNION ALL

SELECT 'customers', COUNT(*)
FROM stage_customers

UNION ALL

SELECT 'products', COUNT(*)
FROM stage_products

UNION ALL

SELECT 'orders', COUNT(*)
FROM stage_orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM stage_order_items

UNION ALL

SELECT 'payments', COUNT(*)
FROM stage_payments

UNION ALL

SELECT 'returns', COUNT(*)
FROM stage_returns;


-- Q58. Recheck primary key uniqueness after cleaning.

SELECT customer_id, COUNT(*) AS occurrences
FROM clean_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*) AS occurrences
FROM clean_products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*) AS occurrences
FROM clean_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT order_item_id, COUNT(*) AS occurrences
FROM clean_order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1;

SELECT payment_id, COUNT(*) AS occurrences
FROM clean_payments
GROUP BY payment_id
HAVING COUNT(*) > 1;

SELECT return_id, COUNT(*) AS occurrences
FROM clean_returns
GROUP BY return_id
HAVING COUNT(*) > 1;

SELECT city_id, COUNT(*) AS occurrences
FROM clean_cities
GROUP BY city_id
HAVING COUNT(*) > 1;


-- Q59. Recheck foreign key integrity after cleaning.

-- Customers referencing valid cities.

SELECT c.customer_id, c.city_id
FROM clean_customers AS c
LEFT JOIN clean_cities AS ci
ON c.city_id = ci.city_id
WHERE ci.city_id IS NULL;

-- Orders referencing valid customers and cities.

SELECT o.order_id, o.customer_id, o.city_id
FROM clean_orders AS o
LEFT JOIN clean_customers AS c
ON o.customer_id = c.customer_id
LEFT JOIN clean_cities AS ci
ON o.city_id = ci.city_id
WHERE c.customer_id IS NULL
OR ci.city_id IS NULL;

-- Order items referencing valid orders and products.

SELECT oi.order_item_id, oi.order_id, oi.product_id
FROM clean_order_items AS oi
LEFT JOIN clean_orders AS o
ON oi.order_id = o.order_id
LEFT JOIN clean_products AS p
ON oi.product_id = p.product_id
WHERE o.order_id IS NULL
OR p.product_id IS NULL;

-- Payments referencing valid orders.

SELECT p.payment_id, p.order_id
FROM clean_payments AS p
LEFT JOIN clean_orders AS o
ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Returns referencing valid order items.

SELECT r.return_id, r.order_item_id
FROM clean_returns AS r
LEFT JOIN clean_order_items AS oi
ON r.order_item_id = oi.order_item_id
WHERE oi.order_item_id IS NULL;


-- Q60. Verify that all required fields and business rules are satisfied.

-- Check customers.

SELECT *
FROM clean_customers
WHERE customer_id IS NULL
OR customer_name IS NULL
OR TRIM(customer_name) = ''
OR city_id IS NULL;


-- Check products.

SELECT *
FROM clean_products
WHERE product_id IS NULL
OR product_name IS NULL
OR TRIM(product_name) = ''
OR unit_cost < 0
OR selling_price <= 0;


-- Check orders.

SELECT *
FROM clean_orders
WHERE order_id IS NULL
OR customer_id IS NULL
OR city_id IS NULL
OR order_date IS NULL
OR order_status IS NULL;


-- Check order items.

SELECT *
FROM clean_order_items
WHERE order_item_id IS NULL
OR order_id IS NULL
OR product_id IS NULL
OR quantity <= 0
OR discount_percent NOT BETWEEN 0 AND 100;


-- Check payments.

SELECT *
FROM clean_payments
WHERE payment_id IS NULL
OR order_id IS NULL
OR payment_date IS NULL
OR amount <= 0;


-- Check returns.

SELECT *
FROM clean_returns
WHERE return_id IS NULL
OR order_item_id IS NULL
OR return_date IS NULL
OR return_quantity <= 0;


-- Check cities.

SELECT *
FROM clean_cities
WHERE city_id IS NULL
OR city_name IS NULL
OR state_name IS NULL
OR region IS NULL;
