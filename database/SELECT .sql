SELECT id, name, email, phone FROM users; -- ✅
------------------------------------------------------------------
SELECT name, price FROM products ORDER BY price DESC; -- ✅
------------------------------------------------------------------
SELECT id, name FROM categories; -- ✅
------------------------------------------------------------------
SELECT id, name, stock FROM products WHERE stock < 100; -- ✅
------------------------------------------------------------------
SELECT id, name, price FROM products WHERE price >= 100; -- ❌ ( SELECT id, name, price FROM products WHERE price > 100; )
------------------------------------------------------------------
SELECT ci.id, ci.cart_id, ci.product_id, ci.quantity, ci.price_at_time,
       u.name AS user_name, p.name AS product_name FROM cart_items ci 
JOIN carts c ON ci.cart_id = c.id
JOIN users u ON c.user_id = u.id
JOIN products p ON ci.product_id = p.id; -- ❌✅ (select * from cart_items;)
------------------------------------------------------------------
SELECT p.name AS product_name, c.name AS category_name, p.price, p.stock
	FROM products p
	JOIN categories c
ON p.category_id = c.id;  -- ✅
------------------------------------------------------------------
SELECT SUM(ci.quantity) AS total_items FROM users u 
	JOIN carts c ON c.user_id = u.id
	JOIN cart_items ci ON ci.cart_id = c.id 
WHERE u.name = 'Alice'AND c.status = 'active'; -- ❌✅ SELECT u.name AS customer, c.id   AS cart_id, SUM(ci.quantity) AS total_items
------------------------------------------------------------------
SELECT o.id AS order_id, u.name AS customer_name, o.total_amount, o.status, o.created_at
	FROM orders o
	JOIN users u
 ON o.user_id = u.id;  -- ✅
 -----------------------------------------------------------------
 SELECT 
 	p.name as products_name,
 	oi.quantity, 
	oi.price_at_time, 
 	(oi.quantity * oi.price_at_time) AS line_total
 FROM order_items oi
 join products p ON p.id = oi.product_id
 WHERE oi.order_id = 1;  -- ✅
  -----------------------------------------------------------------
 

   
