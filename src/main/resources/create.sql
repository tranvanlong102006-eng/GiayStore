-- 1. BẢNG categories
SET IDENTITY_INSERT categories ON;
INSERT INTO categories (id, code, name) VALUES (1, 'CAT01', N'Giày Sneaker');
INSERT INTO categories (id, code, name) VALUES (2, 'CAT02', N'Giày Chạy Bộ');
INSERT INTO categories (id, code, name) VALUES (3, 'CAT03', N'Sandal & Dép');
INSERT INTO categories (id, code, name) VALUES (4, 'CAT04', N'Giày Boot');
INSERT INTO categories (id, code, name) VALUES (5, 'CAT05', N'Giày Tây Da');
SET IDENTITY_INSERT categories OFF;

-- 2. BẢNG brands
SET IDENTITY_INSERT brands ON;
INSERT INTO brands (id, code, name) VALUES (1, 'BR01', 'Nike');
INSERT INTO brands (id, code, name) VALUES (2, 'BR02', 'Adidas');
INSERT INTO brands (id, code, name) VALUES (3, 'BR03', 'Puma');
INSERT INTO brands (id, code, name) VALUES (4, 'BR04', 'Converse');
INSERT INTO brands (id, code, name) VALUES (5, 'BR05', 'Vans');
SET IDENTITY_INSERT brands OFF;

-- 3. BẢNG colors
SET IDENTITY_INSERT colors ON;
INSERT INTO colors (id, code, name) VALUES (1, 'CLR01', N'Đen');
INSERT INTO colors (id, code, name) VALUES (2, 'CLR02', N'Trắng');
INSERT INTO colors (id, code, name) VALUES (3, 'CLR03', N'Đỏ');
INSERT INTO colors (id, code, name) VALUES (4, 'CLR04', N'Xanh Dương');
INSERT INTO colors (id, code, name) VALUES (5, 'CLR05', N'Xám');
SET IDENTITY_INSERT colors OFF;

-- 4. BẢNG sizes (Id là kiểu Integer tự tăng)
SET IDENTITY_INSERT sizes ON;
INSERT INTO sizes (id, code, name) VALUES (1, 'SZ39', '39');
INSERT INTO sizes (id, code, name) VALUES (2, 'SZ40', '40');
INSERT INTO sizes (id, code, name) VALUES (3, 'SZ41', '41');
INSERT INTO sizes (id, code, name) VALUES (4, 'SZ42', '42');
INSERT INTO sizes (id, code, name) VALUES (5, 'SZ43', '43');
SET IDENTITY_INSERT sizes OFF;

-- 5. BẢNG users
SET IDENTITY_INSERT users ON;
INSERT INTO users (id, username, password, email, soDienThoai, role, active) VALUES (1, 'admin', '123456', 'admin@giaystore.com', '0901234567', 'ADMIN', 1);
INSERT INTO users (id, username, password, email, soDienThoai, role, active) VALUES (2, 'nhanvien1', '123456', 'longtv@giaystore.com', '0912345678', 'CUSTOMER', 1);
INSERT INTO users (id, username, password, email, soDienThoai, role, active) VALUES (3, 'nhanvien2', '123456', 'maint@giaystore.com', '0923456789', 'CUSTOMER', 1);
INSERT INTO users (id, username, password, email, soDienThoai, role, active) VALUES (4, 'khachhang1', '123456', 'tuangp@gmail.com', '0934567890', 'CUSTOMER', 1);
INSERT INTO users (id, username, password, email, soDienThoai, role, active) VALUES (5, 'khachhang2', '123456', 'hadt@gmail.com', '0945678901', 'CUSTOMER', 1);
SET IDENTITY_INSERT users OFF;

-- 6. BẢNG products
SET IDENTITY_INSERT products ON;
INSERT INTO products (id, brand_id, category_id, color_id, size_id, img, name, price, quantity, node, active) VALUES (1, 1, 1, 1, 2, '1.jpg', '1', 1500000, 50, N'Hàng chính hãng Air Force 1', 1);
INSERT INTO products (id, brand_id, category_id, color_id, size_id, img, name, price, quantity, node, active) VALUES (2, 1, 2, 2, 3, '2.jpg','1', 2200000, 30, N'Giày chạy bộ Pegasus', 1);
INSERT INTO products (id, brand_id, category_id, color_id, size_id, img, name, price, quantity, node, active) VALUES (3, 2, 1, 2, 4, '3.jpg','1', 1800000, 40, N'Adidas Ultraboost', 1);
INSERT INTO products (id, brand_id, category_id, color_id, size_id, img, name, price, quantity, node, active) VALUES (4, 3, 2, 3, 1, '4.jpg','1', 1200000, 25, N'Puma Suede Classic', 1);
INSERT INTO products (id, brand_id, category_id, color_id, size_id, img, name, price, quantity, node, active) VALUES (5, 4, 3, 1, 2, '5.jpg','1', 950000, 60, N'Converse Chuck Taylor', 1);
SET IDENTITY_INSERT products OFF;

-- 7. BẢNG bills
SET IDENTITY_INSERT bills ON;
INSERT INTO bills (id, code, createDay, user_id, total, status) VALUES (1, 'HD001', '2026-07-20', 4, 1500000, 'PAID');
INSERT INTO bills (id, code, createDay, user_id, total, status) VALUES (2, 'HD002', '2026-07-21', 5, 3600000, 'PAID');
INSERT INTO bills (id, code, createDay, user_id, total, status) VALUES (3, 'HD003', '2026-07-22', 4, 1200000, 'PAID');
INSERT INTO bills (id, code, createDay, user_id, total, status) VALUES (4, 'HD004', '2026-07-23', 5, 950000, 'PENDING');
INSERT INTO bills (id, code, createDay, user_id, total, status) VALUES (5, 'HD005', '2026-07-24', 4, 2200000, 'PAID');
SET IDENTITY_INSERT bills OFF;

-- -- 8. BẢNG billProducts
-- SET IDENTITY_INSERT billProducts ON;
-- INSERT INTO billProducts (id, bill_id, product_id, quantity, price) VALUES (1, 1, 1, 1, 1500000);
-- INSERT INTO billProducts (id, bill_id, product_id, quantity, price) VALUES (2, 2, 3, 2, 1800000);
-- INSERT INTO billProducts (id, bill_id, product_id, quantity, price) VALUES (3, 3, 4, 1, 1200000);
-- INSERT INTO billProducts (id, bill_id, product_id, quantity, price) VALUES (4, 4, 5, 1, 950000);
-- INSERT INTO billProducts (id, bill_id, product_id, quantity, price) VALUES (5, 5, 2, 1, 2200000);
-- SET IDENTITY_INSERT billProducts OFF;