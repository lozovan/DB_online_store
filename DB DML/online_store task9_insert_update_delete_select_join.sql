-- Adding data to the goods table 
INSERT INTO goods (product_name, product_category, product_measurement_unit, unit_price_product, quantity_stock) VALUES
('Laptop', 'Electronics', 'Piece', 1200.00, 50),
('Smartphone', 'Electronics', 'Piece', 800.00, 100),
('Coffee Maker', 'Appliances', 'Piece', 60.00, 20),
('Running Shoes', 'Sports', 'Pair', 80.00, 200),
('Television', 'Electronics', 'Piece', 1500.00, 30),
('Toaster', 'Appliances', 'Piece', 30.00, 15),
('Backpack', 'Fashion', 'Piece', 40.00, 50),
('Dumbbells', 'Sports', 'Pair', 25.00, 100),
('Wristwatch', 'Fashion', 'Piece', 100.00, 80),
('Desk Chair', 'Furniture', 'Piece', 150.00, 25);


-- Adding data to the product_characteristics table
INSERT INTO product_characteristics (goods_id, brand, color, size) VALUES
(1, 'HP', 'Silver', '15 inch'),
(2, 'Samsung', 'Black', '15 inch '),
(3, 'Breville', 'White', '7 inch'),
(4, 'Nike', 'Blue', '8'),
(5, 'Sony', 'Black', '6 inch'),
(6, 'IKEA', 'Silver', 'm'),
(7, 'Adidas', 'Red', 'l'),
(8, 'ProForm', 'Black', '10 kg'),
(9, 'Casio', 'Gold', 'm'),
(10, 'IKEA', 'Black', 'l');

-- Adding data to the customers table
INSERT INTO customers (first_name, last_name, phone_number, delivery_address) VALUES
('John', 'Doe', 123456789, '123 Main St, City'),
('Jane', 'Smith', 987654321, '456 Oak St, Town'),
('Bob', 'Johnson', 555123456, '789 Pine St, Village'),
('Alice', 'Brown', 111222334, '101 Elm St, Hamlet'),
('Charlie', 'Davis', 999888776, '202 Maple St, Borough'),
('Eva', 'White', 444555667, '303 Cedar St, District'),
('David', 'Lee', 777888999, '404 Birch St, Suburb'),
('Grace', 'Miller', 333222111, '505 Redwood St, Quarter'),
('Frank', 'Wilson', 666778888, '606 Spruce St, Sector'),
('Olivia', 'Taylor', 222334444, '707 Pineapple St, Region');

-- Adding data to the shopping_cart table
INSERT INTO shopping_cart (customer_id, order_date, discount, total_price) VALUES
(1, '2024-01-15 08:30:00', 0.05, 1100.00),
(2, '2024-01-16 10:45:00', 0.10, 720.00),
(3, '2023-10-17 12:15:00', 0.00, 60.00),
(4, '2023-10-18 14:30:00', 0.15, 68.00),
(5, '2023-05-19 16:45:00', 0.08, 1380.00),
(6, '2023-06-20 18:00:00', 0.03, 29.10),
(7, '2023-06-21 20:15:00', 0.20, 32.00),
(8, '2023-04-22 22:30:00', 0.12, 176.00),
(9, '2023-03-23 08:00:00', 0.07, 93.00),
(10, '2023-01-24 09:30:00', 0.25, 112.50);

-- Adding records to the cart_items table
INSERT INTO cart_items (cart_id, goods_id, quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 4, 1),
(2, 5, 1),
(3, 6, 2),
(4, 2, 1),
(5, 7, 1),
(5, 8, 2),
(6, 9, 1),
(7, 10, 1);

-- Adding a product to the goods table
INSERT INTO goods (product_name, product_category, product_measurement_unit, unit_price_product, quantity_stock) VALUES 
('Office Desk', 'Furniture', 'Piece', 200.00, 100);

-- Update product with goods_id = 1 quantity in stock
UPDATE goods SET quantity_stock = 20 WHERE goods_id = 1;


-- Updating the total price in the shopping cart
UPDATE shopping_cart
SET total_price = (
    SELECT SUM(cart_items.quantity * goods.unit_price_product)
    FROM cart_items
    JOIN goods ON cart_items.goods_id = goods.goods_id
    WHERE cart_items.cart_id = 1 
)
WHERE cart_id = 1;



-- Update order information for customer № 1 
UPDATE shopping_cart SET 
    discount = 0.1, 
    total_price = 150.00,
    order_date = current_timestamp 
WHERE customer_id = 1;


-- Demonstration of all data tables that exist in the database

SELECT * FROM goods

SELECT * FROM product_characteristics

SELECT * FROM customers

SELECT * FROM shopping_cart

SELECT * FROM cart_items;


-- the query will display information about the first 5 products in the shopping cart, sorting them by order date in reverse order
SELECT
    g.product_name,
    g.product_category,
    pc.brand,
    pc.color,
    pc.size,
    c.first_name || ' ' || c.last_name AS customer_name,
    sc.order_date,
    sc.total_price,
    ci.quantity
FROM
    goods g
JOIN
    product_characteristics pc ON g.goods_id = pc.goods_id
JOIN
    cart_items ci ON g.goods_id = ci.goods_id
JOIN
    shopping_cart sc ON ci.cart_id = sc.cart_id
JOIN
    customers c ON sc.customer_id = c.customer_id
ORDER BY
    sc.order_date DESC;

