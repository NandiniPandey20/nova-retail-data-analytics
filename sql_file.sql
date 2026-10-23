DROP DATABASE IF EXISTS nova_retail_analytics;
CREATE DATABASE nova_retail_analytics;
USE nova_retail_analytics;


USE nova_retail_analytics;

CREATE TABLE stage_cities (
    city_id VARCHAR(50),
    city_name VARCHAR(100),
    state_name VARCHAR(100),
    region VARCHAR(50)
);

CREATE TABLE stage_customers (
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    gender VARCHAR(20),
    age VARCHAR(50),
    city_id VARCHAR(50),
    signup_date VARCHAR(50)
);

CREATE TABLE stage_products (
    product_id VARCHAR(50),
    product_name VARCHAR(150),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    unit_cost VARCHAR(50),
    selling_price VARCHAR(50)
);

CREATE TABLE stage_orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_date VARCHAR(50),
    city_id VARCHAR(50),
    order_status VARCHAR(30)
);

CREATE TABLE stage_order_items (
    order_item_id VARCHAR(50),
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    quantity VARCHAR(50),
    discount_percent VARCHAR(50)
);

CREATE TABLE stage_payments (
    payment_id VARCHAR(50),
    order_id VARCHAR(50),
    payment_date VARCHAR(50),
    payment_method VARCHAR(50),
    payment_status VARCHAR(30),
    amount VARCHAR(50)
);

CREATE TABLE stage_returns (
    return_id VARCHAR(50),
    order_item_id VARCHAR(50),
    return_date VARCHAR(50),
    return_reason VARCHAR(150),
    return_quantity VARCHAR(50)
);


/*
PROJECT: NOVA RETAIL ANALYTICS

STAGING TABLE CREATION
----------------------
All columns were initially created as VARCHAR to safely import
the raw CSV data into MySQL without prematurely converting values.

After importing the data, data type validation was performed
in a separate script: fixing_datatype.sql.

The script modifies eligible columns to their appropriate data
types (INT, DATE, and DECIMAL) while preserving existing data
and intentional data-quality anomalies.

Some columns remain VARCHAR because they contain blank values
that cannot be represented as INT without changing the data.
These columns will be handled during the data-cleaning stage.

IMPORTANT:
Run the datatype-correction script after importing the raw data.
The original CREATE TABLE statements document the initial
staging schema, not necessarily the final schema.
*/



USE nova_retail_analytics;

SELECT 'stage_cities' AS table_name, COUNT(*) AS total_rows
FROM stage_cities
UNION ALL
SELECT 'stage_customers', COUNT(*) FROM stage_customers
UNION ALL
SELECT 'stage_products', COUNT(*) FROM stage_products
UNION ALL
SELECT 'stage_orders', COUNT(*) FROM stage_orders
UNION ALL
SELECT 'stage_order_items', COUNT(*) FROM stage_order_items
UNION ALL
SELECT 'stage_payments', COUNT(*) FROM stage_payments
UNION ALL
SELECT 'stage_returns', COUNT(*) FROM stage_returns;

-- DATA QUALITY CHECKS & DATA INTEGRITY

-- SECTION 1: CUSTOMER DATA QUALITY
-- Q1. Check the total number of records in stage_customers.
select count(*) from stage_customers;

-- Q2. Identify duplicate customer_id values.


select * from stage_customers;
SELECT customer_id as Duplicate_customer_id, COUNT(*) AS duplicate_count
FROM stage_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- Q3. Find missing or blank customer_name values.

select customer_id,customer_name
from stage_customers
where customer_name='   ';

-- #tip: Your original condition, customer_name = '   ', only finds values with exactly three spaces. 
-- Using TRIM() catches blank strings with any number of ordinary spaces.

select customer_id,customer_name
from stage_customers
where customer_name is NULL
OR 
TRIM(customer_name)='';

-- Q4. Find NULL or blank customer_id values.

select customer_id from stage_customers
where customer_id is null
or customer_id=0;

-- Q5. Find missing, negative, or unrealistic age values.
SELECT 
    age
FROM
    stage_customers
WHERE
    age IS NULL OR age < 15 OR age > 100;

-- Q6. Find customers whose city_id does not exist in stage_cities.

select c.customer_name,s.city_id as cities_table_city_id
from stage_cities as s 
left join stage_customers as c
on s.city_id=c.city_id
where s.city_id=0;

#LEFT JOIN keeps all customers, even if their city doesn't exist.

-- SECTION 2: PRODUCT DATA QUALITY
-- Q7. Check the total number of records in stage_products.

select * from stage_products;

-- Q8. Identify duplicate product_id values.

select product_id as duplicate_product_id , count(*) as duplicate_count
from stage_products
group by product_id
having count(*)>1;

-- Q9. Find missing product names and categories.


SELECT
SUM(product_name IS NULL) AS missing_names,
SUM(category IS NULL) AS missing_categories
FROM stage_products;

SELECT COUNT(*) AS blank_values
FROM stage_products
WHERE TRIM(product_name) = ''
   OR TRIM(category) = '';

-- Q10. Find missing, zero, or negative unit_cost values.

select unit_cost from stage_products
where trim(unit_cost)=''
or unit_cost is null
or unit_cost=0
or unit_cost<0;

-- Q11. Find missing, zero, or negative selling_price values.

select selling_price from stage_products
where trim(selling_price)=''
or selling_price is null
or selling_price=0
or selling_price<0;

-- Q12. Find products where selling_price is lower than unit_cost.

select product_id,product_name,selling_price,unit_cost from stage_products
where selling_price-unit_cost<0;

DESCRIBE stage_products;
-- SECTION 3: ORDER DATA QUALITY
-- Q13. Check the total number of records in stage_orders.

select* from stage_orders;

-- Q14. Identify duplicate order_id values.

select order_id , count(*) as duplicate_order_id
from stage_orders
group by order_id
having count(*)>1;
-- Q15. Find orders with missing or blank customer_id values.

select customer_id from stage_orders
where customer_id is null
or trim(customer_id)=''
or customer_id=0;

select count(customer_id) as missing_column from stage_orders
where customer_id is null
or trim(customer_id)=''
group by customer_id
having count(customer_id)>1;


-- Q16. Find orders referencing nonexistent customers.

select order_id, customer_id from stage_orders
where customer_id is null
or customer_id=''
or customer_id=0;

-- Q17. Find orders with missing or invalid city_id values.

select * from stage_orders;

select order_id, city_id from stage_orders
where city_id is null
or city_id=''
or city_id=0;

-- Q18. Find missing or invalid order_date values.

select order_id, order_date from stage_orders
where order_date is null
or order_date=''
or order_date=0
or order_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';

-- Q19. Investigate missing or unexpected order_status values.

select order_id,order_status from stage_orders
where order_status is null
OR TRIM(order_status) = ''
OR TRIM(order_status) NOT IN (
       'Shipped',
       'Cancelled',
       'Processing',
       'Delivered');


-- SECTION 4: ORDER ITEM DATA QUALITY
-- Q20. Check the total number of records in stage_order_items.

select * from stage_order_items;
select count(*) from stage_order_items;

-- Q21. Identify duplicate order_item_id values.

select order_item_id,count(*) as duplicate_order_item_id from stage_order_items
group by order_item_id
having count(*)>1;

-- Q22. Find missing order_id or product_id values.

select order_id,product_id from stage_order_items
where order_id is null
or trim(order_id)=''
or product_id is null
or trim(product_id)=''
or order_id=0
or product_id=0;

-- Q23. Find order items referencing nonexistent orders.

SELECT *
FROM stage_order_items
WHERE order_id IS NULL
   OR TRIM(order_id) = '';

SELECT i.order_item_id, i.order_id
FROM stage_order_items AS i
LEFT JOIN stage_orders AS o
    ON i.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Q24. Find order items referencing nonexistent products.

-- The key lesson: a number can be present, nonzero, and nonblank,
--  yet still be invalid because it doesn't exist in the referenced table. 
-- That's exactly what a foreign-key integrity check is designed to catch. 💪

SELECT i.order_item_id, i.product_id
FROM stage_order_items AS i
LEFT JOIN stage_products AS p
    ON i.product_id = p.product_id
WHERE p.product_id IS NULL;

#classify the issues
SELECT
    i.order_item_id,
    i.product_id,
    CASE
        WHEN i.product_id IS NULL THEN 'NULL value'
        WHEN TRIM(i.product_id) = '' THEN 'Blank value'
        WHEN i.product_id = '0' THEN 'Zero value'
        ELSE 'Non-matching ID'
    END AS issue_type
FROM stage_order_items AS i
LEFT JOIN stage_products AS p
    ON i.product_id = p.product_id
WHERE p.product_id IS NULL;

#This tells you which invalid product IDs exist and how many times each occurs—like your 200002 and 999999 findings.

SELECT i.product_id, COUNT(*) AS occurrences
FROM stage_order_items AS i
LEFT JOIN stage_products AS p
    ON i.product_id = p.product_id
WHERE p.product_id IS NULL
  AND TRIM(i.product_id) <> ''
GROUP BY i.product_id
ORDER BY occurrences DESC;

-- Quick memory trick:  TRIM(i.product_id) = '' → find blank values.
--                      TRIM(i.product_id) <> '' → exclude blank values.
-- So both are valid SQL; they just do opposite things!


-- Q25. Find missing, zero, or negative quantity values.

SELECT * FROM STAGE_ORDER_ITEMS;
SELECT * FROM stage_order_items
WHERE quantity IS NULL
   OR quantity = 0
   OR quantity < 0;

-- Q26. Find discount_percent values outside the range 0–100.

select * from stage_order_items;
select * from stage_order_items
where discount_percent<0
or discount_percent>100;

-- SECTION 5: PAYMENT DATA QUALITY
-- Q27. Check the total number of records in stage_payments.

select * from stage_payments;

-- Q28. Identify duplicate payment_id values.

select payment_id, count(*) as duplicate_payment_id from stage_payments
group by payment_id
having count(*)>1;

-- Q29. Find payments with missing or blank order_id values.

select * from stage_payments;
select payment_id,order_id from stage_payments
where trim(order_id)=''
or order_id is null
or order_id='0';

-- Q30. Find payments referencing nonexistent orders.

-- Q30. Find payments referencing nonexistent orders.

SELECT p.payment_id, p.order_id as order_id_in_payment_table_which_reference_nonexistent_order
FROM stage_payments AS p
LEFT JOIN stage_orders AS o
ON p.order_id = o.order_id
WHERE o.order_id IS NULL
  AND p.order_id IS NOT NULL
  AND TRIM(p.order_id) <> ''
  AND p.order_id <> '0';

    

-- Q31. Find missing or invalid payment_date values.

select * from stage_payments;
select payment_date from stage_payments
where payment_date is null
or trim(payment_date)=''
;

-- Q32. Investigate missing or unexpected payment methods and statuses.

select * from stage_payments;
select payment_method, payment_status from stage_payments
where payment_method is null
or trim(payment_method)=''
or payment_status is null
or trim(payment_status)=''
or payment_method not in ('Net Banking' or 'Cash' or 'UPI' or 'Credit Card' or 'Debit Card')
or payment_status not in  ('Paid' or 'Failed' or 'Pending');


-- Q33. Find missing, zero, or negative payment amounts.

select amount as payment_amount from stage_payments
where amount='0'
or amount=''
or amount<0;

-- SECTION 6: RETURN DATA QUALITY
-- Q34. Check the total number of records in stage_returns.
select count(*) from stage_returns;
-- Q35. Identify duplicate return_id values.
select * from stage_returns;

select return_id,count(return_id) as duplicate_return_id from stage_returns
group by return_id
having count(return_id)>1;
-- Q36. Find returns with missing or blank order_item_id values.
select return_id,order_item_id from stage_returns
where order_item_id is null
or trim(order_item_id)='0'
or trim(order_item_id)='';
-- Q37. Find returns referencing nonexistent order items.

SELECT r.return_id, r.order_item_id
FROM stage_returns AS r
LEFT JOIN stage_order_items AS o
    ON r.order_item_id = o.order_item_id
WHERE r.order_item_id IS NOT NULL
  AND TRIM(r.order_item_id) <> ''
  AND o.order_item_id IS NULL;
  
select order_item_id from stage_order_items
where order_item_id=999999;      # gives 0 rows
  
-- Q38. Find missing or invalid return_date values.
select * from stage_returns;
select return_date from stage_returns
where return_date is null
or trim(return_date)='';
-- Q39. Find missing, zero, or negative return_quantity values.
-- Q39. Find missing, zero, or negative return_quantity values.

SELECT *
FROM stage_returns
WHERE return_quantity IS NULL
   OR return_quantity = 0
   OR return_quantity < 0;

-- Q40. Compare return_quantity with the original ordered quantity.

select * from stage_returns as r
join
stage_order_items as o
on r.order_item_id=o.order_item_id;

-- SECTION 7: CITY DATA QUALITY

-- Q41. Check the total number of records in stage_cities.

SELECT COUNT(*) AS total_city_records
FROM stage_cities;


-- Q42. Identify duplicate city_id values.

SELECT city_id, COUNT(*) AS occurrences
FROM stage_cities
GROUP BY city_id
HAVING COUNT(*) > 1;


-- Q43. Find missing or blank city_name values.

SELECT *
FROM stage_cities
WHERE city_name IS NULL
   OR TRIM(city_name) = '';


-- Q44. Find missing or blank state_name values.

SELECT *
FROM stage_cities
WHERE state_name IS NULL
   OR TRIM(state_name) = '';


-- Q45. Find missing or blank region values.

SELECT *
FROM stage_cities
WHERE region IS NULL
   OR TRIM(region) = '';


-- SECTION 8: CROSS-TABLE DATA INTEGRITY
-- Q46. Verify that every customer references a valid city.
-- Q47. Verify that every order references a valid customer and city.
-- Q48. Verify that every order item references a valid order and product.
-- Q49. Verify that every payment references a valid order.
-- Q50. Verify that every return references a valid order item.
-- Q51. Investigate whether multiple payments per order are valid.

-- SECTION 9: DATA CLEANING & VALIDATION
-- Q52. Decide how to handle duplicate primary key values.
-- Q53. Decide how to handle missing required values.
-- Q54. Decide how to handle invalid foreign key references.
-- Q55. Decide how to handle invalid prices, quantities, and discounts.
-- Q56. Record the cleaning rules applied to each issue.
-- Q57. Compare row counts before and after cleaning.
-- Q58. Recheck primary key uniqueness after cleaning.
-- Q59. Recheck foreign key integrity after cleaning.
-- Q60. Verify that all required fields and business rules are satisfied.

-- =====================================================
