--calculate_total_price
CREATE OR REPLACE FUNCTION calculate_total_price(cart_id INT)
RETURNS TABLE (
    product_name VARCHAR(50),
    total_price DECIMAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        g.product_name,
        SUM(ci.quantity * g.unit_price_product) AS total_price
    FROM
        cart_items ci
    JOIN
        goods g ON ci.goods_id = g.goods_id
    WHERE
        ci.cart_id = calculate_total_price.cart_id
    GROUP BY
        g.product_name;

END;
$$ LANGUAGE plpgsql;

SELECT
    cart_id,
    (calculate_total_price(cart_id)).product_name AS product_name,
    (calculate_total_price(cart_id)).total_price AS total_price
FROM
    shopping_cart;
--get_shopping_history
CREATE OR REPLACE FUNCTION get_shopping_history(p_customer_id INT DEFAULT NULL)
RETURNS TABLE (
    product_name VARCHAR(50),
    order_date TIMESTAMP,
    quantity INT,
    total_price DECIMAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        g.product_name,
        sc.order_date,
        ci.quantity,
        sc.total_price
    FROM
        cart_items ci
    JOIN
        shopping_cart sc ON ci.cart_id = sc.cart_id
    JOIN
        goods g ON ci.goods_id = g.goods_id
    WHERE
        (p_customer_id IS NULL OR sc.customer_id = p_customer_id);

END;
$$ LANGUAGE plpgsql;

SELECT
    product_name,
    order_date,
    quantity,
    total_price
FROM
    get_shopping_history();
--update_product_price
CREATE OR REPLACE FUNCTION update_product_price(product_id INT, new_price DECIMAL)
RETURNS VOID AS $$
BEGIN
    UPDATE goods
    SET unit_price_product = new_price
    WHERE goods_id = update_product_price.product_id;
END;
$$ LANGUAGE plpgsql;
   
SELECT update_product_price(1, 15.99);
SELECT update_product_price(2, 25.99);
SELECT update_product_price(3, 19.99);
SELECT update_product_price(4, 29.99);
SELECT update_product_price(5, 22.99);


SELECT * FROM goods WHERE goods_id IN (1, 2, 3, 4, 5);

--get_customer_order_details
CREATE OR REPLACE PROCEDURE get_customer_order_details(IN customer_id INTEGER)
AS $$
DECLARE
    order_details_record RECORD;
BEGIN
    SELECT * INTO order_details_record
    FROM shopping_cart sc
    JOIN customers c ON sc.customer_id = c.customer_id
    JOIN cart_items ci ON sc.cart_id = ci.cart_id
    JOIN goods g ON ci.goods_id = g.goods_id
    WHERE c.customer_id = get_customer_order_details.customer_id;

    RAISE NOTICE 'Order Details:';
    RAISE NOTICE 'Customer ID: %', order_details_record.customer_id;
    RAISE NOTICE 'First Name: %', order_details_record.first_name;
    RAISE NOTICE 'Last Name: %', order_details_record.last_name;
    RAISE NOTICE 'Order Date: %', order_details_record.order_date;

END;
$$ LANGUAGE plpgsql;

CALL get_customer_order_details(4);
CALL get_customer_order_details(5);
CALL get_customer_order_details(6);

--get_product_details

CREATE OR REPLACE PROCEDURE get_product_details(IN product_id INTEGER)
AS $$
DECLARE
    product_details_record RECORD;
BEGIN
    SELECT * INTO product_details_record
    FROM goods
    WHERE goods_id = get_product_details.product_id;

    RAISE NOTICE 'Product Details:';
    RAISE NOTICE 'Product ID: %', product_details_record.goods_id;
    RAISE NOTICE 'Product Name: %', product_details_record.product_name;
    RAISE NOTICE 'Category: %', product_details_record.product_category;
    RAISE NOTICE 'Unit Price: %', product_details_record.unit_price_product;
    RAISE NOTICE 'Quantity in Stock: %', product_details_record.quantity_stock;

END;
$$ LANGUAGE plpgsql;


CALL get_product_details(1);
CALL get_product_details(3);
CALL get_product_details(5);

--insert_customer
CREATE OR REPLACE PROCEDURE insert_customer(
    p_first_name VARCHAR(50),
    p_last_name VARCHAR(50),
    p_phone_number INTEGER,
    p_delivery_address VARCHAR(255)
)
AS $$
BEGIN
    INSERT INTO customers (first_name, last_name, phone_number, delivery_address)
    VALUES (p_first_name, p_last_name, p_phone_number, p_delivery_address);

    RAISE NOTICE 'Customer inserted successfully! Customer: % %', p_first_name, p_last_name;
END;
$$ LANGUAGE plpgsql;


CALL insert_customer('John', 'Doe', 1234567890, '123 Main St');
CALL insert_customer('Vitalii', 'Lozovan', 0971165321, '123 Main St');

--insert_product
CREATE OR REPLACE PROCEDURE insert_product(
    p_product_name VARCHAR(50),
    p_product_category VARCHAR(50),
    p_product_measurement_unit VARCHAR(50),
    p_unit_price DECIMAL(10, 2),
    p_quantity_in_stock INT
)
AS $$
BEGIN
    INSERT INTO goods (product_name, product_category, 
    product_measurement_unit, unit_price_product, quantity_stock)
    VALUES (p_product_name, p_product_category, p_product_measurement_unit, 
   p_unit_price, p_quantity_in_stock);

    RAISE NOTICE 'Product inserted successfully! Product: %, Category: %', p_product_name, p_product_category;
END;
$$ LANGUAGE plpgsql;

CALL insert_product('Laptop', 'Electronics', 'Piece', 1200.50, 50);
