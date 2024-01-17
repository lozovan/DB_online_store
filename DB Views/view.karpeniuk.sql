

create view horizontal_view as
select customer_id, first_name, last_name, phone_number
from customers;

create view vertical_view as
select *
from goods g
where product_measurement_unit = 'Item';

create view mixed_view as
select product_name, product_category, unit_price_product as unit_price
from goods 
where product_measurement_unit = 'Item' and unit_price_product >= 129.99;

create view join_view as
select g.product_name, g.product_category, pc.brand, pc.color, pc."size" 
from goods g 
join product_characteristics pc on g.goods_id = pc.goods_id;

create view subquery_view as
select g.product_name, g.product_category,
(select sum(quantity) 
from cart_items ci 
where ci.goods_id = g.goods_id ) as total_quantity
from goods g;

create view union_view as
select g.product_name, null as quantity
from goods g 
union
select null as product_name, cast(ci.quantity as varchar) as quantity
FROM cart_items ci;

create view view_on_view as
select vv.product_name, vv.product_category
from vertical_view vv 
where vv.unit_price_product < 150
order by vv.unit_price_product desc; 

create view check_view as
select g.product_name, g.product_category, g.unit_price_product 
from goods g  
where g.unit_price_product > 100
with check option;
