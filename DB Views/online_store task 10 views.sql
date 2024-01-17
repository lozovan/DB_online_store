--  horizontal_view 
CREATE VIEW horizontal_view AS
SELECT goods_id, product_name, unit_price_product
FROM goods;

SELECT * FROM horizontal_view;

--  vertical_view
CREATE VIEW vertical_goods_view AS
SELECT
    'goods' AS source,
    goods_id AS id,
    product_name AS name,
    product_category AS category,
    product_measurement_unit AS measurement_unit,
    unit_price_product AS unit_price,
    quantity_stock AS quantity
FROM goods;

SELECT * FROM vertical_goods_view;

-- mixed_view
CREATE VIEW mixed_view AS
SELECT
    ci.cart_item_id,
    ci.cart_id,
    ci.goods_id,
    ci.quantity,
    g.product_name,
    g.product_category,
    g.product_measurement_unit,
    g.unit_price_product,
    g.quantity_stock,
    pc.brand,
    pc.color,
    pc.size
FROM cart_items ci
JOIN goods g ON ci.goods_id = g.goods_id
LEFT JOIN product_characteristics pc ON g.goods_id = pc.goods_id;

SELECT * FROM mixed_view;

-- joining_view
CREATE VIEW joining_view AS
SELECT
    g.goods_id,
    g.product_name,
    g.product_category,
    g.product_measurement_unit,
    g.unit_price_product,
    g.quantity_stock,
    pc.brand,
    pc.color,
    pc.size
FROM goods g
JOIN product_characteristics pc ON g.goods_id = pc.goods_id;

SELECT * FROM joining_view;

-- subquery_view
CREATE VIEW subquery_view AS
SELECT
    sc.cart_id,
    sc.total_price,
    COALESCE(SUM(ci.quantity), 0) AS total_quantity
FROM shopping_cart sc
LEFT JOIN cart_items ci ON sc.cart_id = ci.cart_id
GROUP BY sc.cart_id, sc.total_price
HAVING sc.total_price > 100;

SELECT * FROM subquery_view;

-- union_view
CREATE VIEW union_view AS
SELECT
    goods_id,
    product_name,
    product_category,
    product_measurement_unit,
    unit_price_product,
    quantity_stock
FROM goods

UNION

SELECT
    pc.goods_id,
    NULL AS product_name,
    NULL AS product_category,
    NULL AS product_measurement_unit,
    NULL AS unit_price_product,
    NULL AS quantity_stock
FROM (
    SELECT goods_id
    FROM product_characteristics
    GROUP BY goods_id
) pc;

SELECT * FROM union_view;

--view on the select from another one view
CREATE VIEW subquery_view_one AS
SELECT
    sc.cart_id,
    sc.total_price,
    COALESCE(SUM(ci.quantity), 0) AS total_quantity
FROM shopping_cart sc
LEFT JOIN cart_items ci ON sc.cart_id = ci.cart_id
GROUP BY sc.cart_id, sc.total_price;

SELECT * FROM subquery_view_one;

CREATE VIEW view_based_on_subquery_view AS
SELECT
    cart_id,
    total_price,
    total_quantity,
    CASE
        WHEN total_price > 500 THEN 'High Value'
        ELSE 'Low Value'
    END AS price_category
FROM subquery_view_one;

SELECT * FROM view_based_on_subquery_view;

--view with check option
CREATE VIEW view_with_check_option AS
SELECT
    goods_id,
    product_name,
    quantity_stock
FROM goods
WHERE quantity_stock > 30
WITH CHECK OPTION;

SELECT * FROM view_with_check_option;








 

