insert into customers (first_name, last_name, phone_number, delivery_address)
values
  ('Ivan', 'Petrov', '0971234567', 'Heroes of Ukraine St., 10'),
  ('Maria', 'Ivanova', '0662345678', 'Independence Ave., 25'),
  ('Oleksandr', 'Kovalenko', '0953456789', 'Shevchenko St., 5'),
  ('Tetiana', 'Sydorenko', '0984567890', 'Victory Ave., 15'),
  ('Andrii', 'Melnik', '0935678901', 'Gagarin St., 30'),
  ('Yulia', 'Lysenko', '0666789012', 'Unity Ave., 8'),
  ('Vitalii', 'Bondarenko', '0977890123', 'Stetsenko St., 12'),
  ('Olha', 'Savchenko', '0958901234', 'Lesi Ukrainky Ave., 40'),
  ('Petro', 'Moroz', '0989012345', 'Taras Shevchenko St., 22'),
  ('Nataliia', 'Kuzmenko', '0930123456', 'Hrushevskoho Ave., 18');

insert into goods (product_name, product_category, product_measurement_unit, unit_price_product, quantity_stock)
values 
('Laptop', 'Electronics', 'Item', 999.99, 20),
('Running Shoes', 'Footwear', 'Pair', 49.99, 50),
('Coffee Maker', 'Appliances', 'Item', 39.99, 30),
('Office Chair', 'Furniture', 'Item', 129.99, 15),
('Fresh Apples', 'Groceries', 'Kilogram', 2.99, 100),
('Digital Camera', 'Photography', 'Item', 299.99, 10),
('Yoga Mat', 'Fitness', 'Item', 15.99, 40),
('Bedside Lamp', 'Home Decor', 'Item', 19.99, 25),
('Backpack', 'Fashion', 'Item', 29.99, 60),
('Gaming Console', 'Video Games', 'Item', 399.99, 5);


insert into product_characteristics (goods_id, brand, color, size)
values
(1, 'Asus', 'Black', '15.6'),
(2, 'Nike', 'White', '40'),
(3, 'Siemens', 'Silver', 'Small'),
(4, 'OfficeComfort', 'Brown', 'Adjustable'),
(5, 'Famberry', 'Red', 'Small'),
(6, 'Canon', 'Silver', 'Full Frame'),
(7, 'FitLife', 'Blue', 'Standard'),
(8, 'HomeEssentials', 'White', 'One Size'),
(9, 'FashionGear', 'Black', 'Medium'),
(10, 'Sony', 'Black', 'Standard');
 insert into cart_items (cart_id, goods_id, quantity)
values
(1, 1, 22),
(2, 2, 55),
(3, 3, 37),
(4, 4, 16),
(5, 5, 111),
(6, 6, 13),
(7, 7, 44),
(8, 8, 29),
(9, 9, 64),
(10, 10, 8)

insert into shopping_cart (customer_id, order_date, discount, total_price)
values
(1, '2024-01-13 23:10:12', 0.1, 150.99),
(2, '2024-01-12 20:10:11', 0.05, 200.50),
(3, '2024-01-12 10:10:11', 0.2, 300.25),
(4, '2024-01-10 09:18:23', 0.15, 180.75),
(5, '2024-01-20 13:55:32', 0.1, 250.00),
(6, '2023-12-20 16:55:32', 0.05, 120.50),
(7, '2023-11-10 19:38:32', 0.2, 350.99),
(8, '2023-11-15 19:42:32', 0.1, 220.25),
(9, '2023-11-15 22:42:32', 0.15, 180.75),
(10, '2024-11-15 23:08:32', 0.05, 270.00);


UPDATE shopping_cart
SET order_date = '2023-11-15 23:08:32'
where cart_id = 10 ;

select g.product_name, 
g.product_category, 
pc.brand, 
pc.color, 
pc."size", 
ci.quantity, 
sc.order_date, 
sc.discount, 
sc.total_price, c.first_name || ' ' || c.last_name as customer_name
from goods g 
join product_characteristics pc on g.goods_id  = pc.goods_id
join cart_items ci on g.goods_id = ci.goods_id
join shopping_cart sc on ci.cart_id = sc.cart_id 
join customers c on c.customer_id = sc.customer_id
order by sc.order_date asc;

