#!/bin/bash

MYSQL_ROOT_PASSWORD="123456"

# Bảo mật cài đặt MySQL
mysql --user=root --password="$MYSQL_ROOT_PASSWORD" <<-EOF
-- Đặt mật khẩu cho người dùng root
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

-- Xóa người dùng ẩn danh
DELETE FROM mysql.user WHERE User='';

-- Không cho phép root đăng nhập từ xa
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- Xóa database test
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

-- Tải lại các bảng quyền hạn
FLUSH PRIVILEGES;
EOF
