--store_support
CREATE ROLE store_support LOGIN PASSWORD 'support@12';
GRANT USAGE ON SCHEMA public TO online_store_support;
GRANT SELECT ON customers, shopping_cart, goods TO online_store_support;

--goods_adder_user
CREATE ROLE goods_adder_user LOGIN PASSWORD 'test@123!';
GRANT CREATE, USAGE ON SCHEMA public TO goods_adder_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO goods_adder_user;