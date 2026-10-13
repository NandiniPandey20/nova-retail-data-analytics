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
-- Q2. Identify duplicate customer_id values.
-- Q3. Find missing or blank customer_name values.
-- Q4. Find NULL or blank customer_id values.
-- Q5. Find missing, negative, or unrealistic age values.
-- Q6. Find customers whose city_id does not exist in stage_cities.

-- SECTION 2: PRODUCT DATA QUALITY
-- Q7. Check the total number of records in stage_products.
-- Q8. Identify duplicate product_id values.
-- Q9. Find missing product names and categories.
-- Q10. Find missing, zero, or negative unit_cost values.
-- Q11. Find missing, zero, or negative selling_price values.
-- Q12. Find products where selling_price is lower than unit_cost.

-- SECTION 3: ORDER DATA QUALITY
-- Q13. Check the total number of records in stage_orders.
-- Q14. Identify duplicate order_id values.
-- Q15. Find orders with missing or blank customer_id values.
-- Q16. Find orders referencing nonexistent customers.
-- Q17. Find orders with missing or invalid city_id values.
-- Q18. Find missing or invalid order_date values.
-- Q19. Investigate missing or unexpected order_status values.

-- SECTION 4: ORDER ITEM DATA QUALITY
-- Q20. Check the total number of records in stage_order_items.
-- Q21. Identify duplicate order_item_id values.
-- Q22. Find missing order_id or product_id values.
-- Q23. Find order items referencing nonexistent orders.
-- Q24. Find order items referencing nonexistent products.
-- Q25. Find missing, zero, or negative quantity values.
-- Q26. Find discount_percent values outside the range 0–100.

-- SECTION 5: PAYMENT DATA QUALITY
-- Q27. Check the total number of records in stage_payments.
-- Q28. Identify duplicate payment_id values.
-- Q29. Find payments with missing or blank order_id values.
-- Q30. Find payments referencing nonexistent orders.
-- Q31. Find missing or invalid payment_date values.
-- Q32. Investigate missing or unexpected payment methods and statuses.
-- Q33. Find missing, zero, or negative payment amounts.

-- SECTION 6: RETURN DATA QUALITY
-- Q34. Check the total number of records in stage_returns.
-- Q35. Identify duplicate return_id values.
-- Q36. Find returns with missing or blank order_item_id values.
-- Q37. Find returns referencing nonexistent order items.
-- Q38. Find missing or invalid return_date values.
-- Q39. Find missing, zero, or negative return_quantity values.
-- Q40. Compare return_quantity with the original ordered quantity.

-- SECTION 7: CITY DATA QUALITY
-- Q41. Check the total number of records in stage_cities.
-- Q42. Identify duplicate city_id values.
-- Q43. Find missing or blank city_name values.
-- Q44. Find missing or blank state_name values.
-- Q45. Find missing or blank region values.

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
