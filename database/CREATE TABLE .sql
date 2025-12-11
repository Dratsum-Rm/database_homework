CREATE TABLE users (
    id          INTEGER PRIMARY KEY AUTOINCREMENT, --int
    name        TEXT NOT NULL, -- String || not null คือ ห้ามค่าว่าง หรือ ไม่มีค่า || null = ค่าว่าง || String text = ""; || String text = null; || String text = number.convertToString(123); -> null | text = null 
    email       TEXT NOT NULL UNIQUE, -- Id 1 , email abc@mail.com || Id 2 , email abc@mail.com X
    phone       TEXT,
    created_at  TEXT NOT NULL
);

--------------------------------------------------
-- 3. CATEGORIES (product groups)
--------------------------------------------------
CREATE TABLE categories (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,--เลขไอดีแบบออโต้
    name        TEXT NOT NULL UNIQUE --ชื่อห้ามมีค่าว่างและไม่ซ้ำ
);

--------------------------------------------------
-- 4. PRODUCTS
--------------------------------------------------
CREATE TABLE products (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    name         TEXT NOT NULL,
    description  TEXT,
    price        REAL NOT NULL, --real ให้เป็นปัจจุบัน(มั่ง) ห้ามค่าว่าง
    stock        INTEGER NOT NULL DEFAULT 0,--เริ่มที่ 0
    category_id  INTEGER,
    created_at   TEXT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id) -- table(id)
);

--------------------------------------------------
-- 5. CARTS (one active cart per user in this simple model)
--------------------------------------------------
CREATE TABLE carts (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id     INTEGER NOT NULL,
    status      TEXT NOT NULL DEFAULT 'active', -- active / converted / abandoned
    created_at  TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

--------------------------------------------------
-- 6. CART ITEMS
--------------------------------------------------
CREATE TABLE cart_items (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    cart_id        INTEGER NOT NULL,
    product_id     INTEGER NOT NULL,
    quantity       INTEGER NOT NULL,
    price_at_time  REAL NOT NULL, -- copy from products.price when added
    FOREIGN KEY (cart_id) REFERENCES carts(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

--------------------------------------------------
-- 7. ORDERS
--------------------------------------------------
CREATE TABLE orders (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id       INTEGER NOT NULL,
    total_amount  REAL NOT NULL,
    status        TEXT NOT NULL,      -- pending / paid / shipped / cancelled
    created_at    TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

--------------------------------------------------
-- 8. ORDER ITEMS
--------------------------------------------------
CREATE TABLE order_items (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id       INTEGER NOT NULL,
    product_id     INTEGER NOT NULL,
    quantity       INTEGER NOT NULL,
    price_at_time  REAL NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);