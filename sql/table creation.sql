CREATE TABLE dim_customers (
    customer_id         INT PRIMARY KEY,
    customer_fname      VARCHAR(100),
    customer_segment    VARCHAR(50),
    customer_city       VARCHAR(100),
    customer_state      VARCHAR(100),
    customer_country    VARCHAR(100)
);

CREATE TABLE dim_products (
    product_card_id     INT PRIMARY KEY,
    product_name        VARCHAR(200),
    product_price       FLOAT,
    product_status      INT,
    category_id         INT,
    category_name       VARCHAR(100),
    department_id       INT,
    department_name     VARCHAR(100)
);

CREATE TABLE dim_shipping (
    order_id                INT PRIMARY KEY,
    shipping_mode           VARCHAR(50),
    days_shipping_real      INT,
    days_shipment_scheduled INT,
    delivery_delay_days     INT,
    delay_flag              INT,
    delay_category          VARCHAR(50),
    delivery_status         VARCHAR(50),
    late_delivery_risk      INT
);

CREATE TABLE dim_geography (
    geo_id          SERIAL PRIMARY KEY,
    order_region    VARCHAR(100),
    order_country   VARCHAR(100),
    order_city      VARCHAR(100),
    order_state     VARCHAR(100),
    market          VARCHAR(50)
);

CREATE TABLE fact_orders (
    order_id                    INT,
    order_customer_id           INT,
    product_card_id             INT,
    order_item_id               INT,
    order_date                  TIMESTAMP,
    shipping_date               TIMESTAMP,
    days_shipping_real          INT,
    days_shipment_scheduled     INT,
    delivery_delay_days         INT,
    delay_flag                  INT,
    delay_category              VARCHAR(50),
    delivery_status             VARCHAR(50),
    late_delivery_risk          INT,
    shipping_mode               VARCHAR(50),
    quantity                    INT,
    sales                       FLOAT,
    benefit_per_order           FLOAT,
    order_item_total            FLOAT,
    order_profit_per_order      FLOAT,
    order_item_discount         FLOAT,
    order_item_discount_rate    FLOAT,
    order_item_product_price    FLOAT,
    order_item_profit_ratio     FLOAT,
    profit_margin               FLOAT,
    shipping_efficiency         FLOAT,
    order_month                 INT,
    order_month_name            VARCHAR(20),
    order_year                  INT,
    order_quarter               INT,
    order_status                VARCHAR(50),
    order_region                VARCHAR(100),
    order_country               VARCHAR(100),
    market                      VARCHAR(50)
);

-- Confirm
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

SELECT 'fact_orders'   AS table_name, COUNT(*) AS rows FROM fact_orders
UNION ALL
SELECT 'dim_customers' AS table_name, COUNT(*) AS rows FROM dim_customers
UNION ALL
SELECT 'dim_products'  AS table_name, COUNT(*) AS rows FROM dim_products
UNION ALL
SELECT 'dim_shipping'  AS table_name, COUNT(*) AS rows FROM dim_shipping
UNION ALL
SELECT 'dim_geography' AS table_name, COUNT(*) AS rows FROM dim_g-- Test insert one row manually
INSERT INTO dim_products (
    product_card_id, product_name, product_price,
    product_status, category_id, category_name,
    department_id, department_name
) VALUES (
    1, 'Test Product', 9.99,
    1, 1, 'Test Category',
    1, 'Test Department'
);

-- Check if it inserted
SELECT COUNT(*) FROM dim_products;geography

