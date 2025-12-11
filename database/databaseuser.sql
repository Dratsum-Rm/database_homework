-- RESET ALL TABLES
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS cart_items;
DROP TABLE IF EXISTS carts;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

--------------------------------------------------
-- 1. USERS
--------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL,
    email       TEXT NOT NULL UNIQUE,
    phone       TEXT,
    created_at  TEXT NOT NULL
);

--------------------------------------------------
-- 2. CATEGORIES
--------------------------------------------------
CREATE TABLE IF NOT EXISTS categories (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL UNIQUE
);

--------------------------------------------------
-- 3. PRODUCTS
--------------------------------------------------
CREATE TABLE IF NOT EXISTS products (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    name         TEXT NOT NULL,
    description  TEXT,
    price        REAL NOT NULL,
    stock        INTEGER NOT NULL DEFAULT 0,
    category_id  INTEGER,
    created_at   TEXT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

--------------------------------------------------
-- 4. CARTS
--------------------------------------------------
CREATE TABLE IF NOT EXISTS carts (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id     INTEGER NOT NULL,
    status      TEXT NOT NULL DEFAULT 'active',
    created_at  TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

--------------------------------------------------
-- 5. CART ITEMS
--------------------------------------------------
CREATE TABLE IF NOT EXISTS cart_items (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    cart_id        INTEGER NOT NULL,
    product_id     INTEGER NOT NULL,
    quantity       INTEGER NOT NULL,
    price_at_time  REAL NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES carts(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

--------------------------------------------------
-- 6. ORDERS
--------------------------------------------------
CREATE TABLE IF NOT EXISTS orders (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id       INTEGER NOT NULL,
    total_amount  REAL NOT NULL,
    status        TEXT NOT NULL,
    created_at    TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

--------------------------------------------------
-- 7. ORDER ITEMS
--------------------------------------------------
CREATE TABLE IF NOT EXISTS order_items (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id       INTEGER NOT NULL,
    product_id     INTEGER NOT NULL,
    quantity       INTEGER NOT NULL,
    price_at_time  REAL NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

--------------------------------------------------
-- INSERT DATA
--------------------------------------------------

-- USERS
INSERT INTO users (name, email, phone, created_at) VALUES
('Alice', 'alice@example.com', '080-000-0001', '2025-12-10T10:00:00Z'),
('Bob', 'bob@example.com', '080-000-0002', '2025-12-10T10:30:00Z'),
('Charlie','charlie@example.com','080-000-0003','2025-12-10T11:00:00Z');

-- CATEGORIES
INSERT INTO categories (name) VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home & Kitchen');

-- PRODUCTS
INSERT INTO products (name, description, price, stock, category_id, created_at) VALUES
('Smartphone X1', 'High-end smartphone with OLED display', 599.99, 50, 1, '2025-12-10T12:00:00Z'),
('Wireless Headphones', 'Noise-cancelling over-ear headphones', 129.99, 120, 1, '2025-12-10T12:05:00Z'),
('T-Shirt Black M', '100% cotton unisex t-shirt (size M)', 19.99, 200, 2, '2025-12-10T12:10:00Z'),
('T-Shirt White L', '100% cotton unisex t-shirt (size L)', 21.99, 150, 2, '2025-12-10T12:12:00Z'),
('Fantasy Novel Vol.1', 'First book in fantasy series', 9.99, 80, 3, '2025-12-10T12:15:00Z'),
('Coffee Mug 350ml', 'Ceramic mug, dishwasher safe', 7.50, 100, 4, '2025-12-10T12:20:00Z');

-- CART FOR ALICE
INSERT INTO carts (user_id, status, created_at) VALUES
(1, 'active', '2025-12-10T13:00:00Z');

-- CART ITEMS
INSERT INTO cart_items (cart_id, product_id, quantity, price_at_time) VALUES
(1, 1, 1, 599.99),
(1, 3, 2, 19.99);

-- ORDER
INSERT INTO orders (user_id, total_amount, status, created_at) VALUES
(1, 599.99 + 2*19.99, 'paid', '2025-12-10T14:00:00Z');

-- ORDER ITEMS
INSERT INTO order_items (order_id, product_id, quantity, price_at_time) VALUES
(1, 1, 1, 599.99),
(1, 3, 2, 19.99);