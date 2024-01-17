CREATE TABLE goods (
    goods_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    product_category VARCHAR(50) NOT NULL,
    product_measurement_unit VARCHAR(20) NOT NULL,
    unit_price_product DECIMAL(10,2),
    quantity_stock INTEGER NOT NULL
);

CREATE TABLE product_characteristics (
    characteristic_id SERIAL PRIMARY KEY,
    goods_id INTEGER,
    brand VARCHAR(50) NOT NULL,
    color VARCHAR(16) NOT NULL,
    size VARCHAR(10) NOT NULL,
    FOREIGN KEY (goods_id) REFERENCES goods(goods_id) ON UPDATE CASCADE
);
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number INTEGER NOT NULL,
    delivery_address VARCHAR NOT NULL
);

CREATE TABLE shopping_cart (
    cart_id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    order_date TIMESTAMP NOT NULL,
    discount FLOAT,
    total_price DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON UPDATE CASCADE
);

CREATE TABLE cart_items (
    cart_item_id SERIAL PRIMARY KEY,
    cart_id INTEGER,
    goods_id INTEGER,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES shopping_cart(cart_id) ON UPDATE CASCADE,
    FOREIGN KEY (goods_id) REFERENCES goods(goods_id) ON UPDATE CASCADE
);