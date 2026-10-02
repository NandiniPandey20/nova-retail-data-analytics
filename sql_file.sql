create database nova_retail_analytics;
use nova_retail_analytics;
CREATE TABLE cities (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    state_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    gender VARCHAR(20),
    age INT,
    city_id INT,
    signup_date DATE,

    CONSTRAINT fk_customer_city
        FOREIGN KEY (city_id)
        REFERENCES cities(city_id)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100) NOT NULL,
    sub_category VARCHAR(100),
    unit_cost NUMERIC(12,2) NOT NULL,
    selling_price NUMERIC(12,2) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    city_id INT NOT NULL,
    order_status VARCHAR(30) NOT NULL,

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_order_city
        FOREIGN KEY (city_id)
        REFERENCES cities(city_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    discount_percent NUMERIC(5,2) DEFAULT 0,

    CONSTRAINT fk_order_item_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_order_item_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_method VARCHAR(50),
    payment_status VARCHAR(30),
    amount NUMERIC(12,2) NOT NULL,

    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

CREATE TABLE returns (
    return_id INT PRIMARY KEY,
    order_item_id INT NOT NULL,
    return_date DATE,
    return_reason VARCHAR(150),
    return_quantity INT NOT NULL,

    CONSTRAINT fk_return_order_item
        FOREIGN KEY (order_item_id)
        REFERENCES order_items(order_item_id)
);

#Loading the generated CSV data from python into MySQL
#Importing the tables in dependency order to maintain relationships

#Verifying that the generated data has been loaded successfully


TRUNCATE TABLE orders;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE orders;
SET FOREIGN_KEY_CHECKS = 1;

select * from cities;
select * from customers;
select * from products;
select * from orders;
select * from order_items;
select * from payments;
select * from returns;
#SUCCEFULLY IMPORTED THE CSV FILES AS TABLE CONTENTS IN MYSQL

#The database is loaded. Time to make sure everything is connected properly
#DATA INTEGRITY check 

-- checking if all datas are imported succesfully.

SELECT COUNT(*) AS total_cities
FROM cities;
SELECT COUNT(*) AS total_customers
FROM customers;
SELECT COUNT(*) AS total_order_items
FROM order_items;
SELECT COUNT(*) AS total_orders
FROM orders;
SELECT COUNT(*) AS total_payments
FROM payments;
SELECT COUNT(*) AS total_products
FROM products;
SELECT COUNT(*) AS total_returns
FROM returns;

-- Are all customer_ids in orders valid?


-- Are all product_ids in order items valid?
-- Are all payments linked to real orders?
-- Are all returns linked to real order items?
-- Any duplicate primary keys?
-- Any unexpected NULLs?
-- Do the relationships make sense?




