#!/bin/bash

# Nhập thông tin proxy từ người dùng
read -p "Enter Proxy (vd: http://username:password@proxy-server:port): " PROXY

# Thiết lập proxy cho APT
echo "Thiết lập proxy cho APT..."
echo "Acquire::http::Proxy \"$PROXY/\";" | sudo tee /etc/apt/apt.conf.d/99proxy > /dev/null
echo "Acquire::https::Proxy \"$PROXY/\";" | sudo tee -a /etc/apt/apt.conf.d/99proxy > /dev/null

# Thiết lập biến môi trường cho toàn hệ thống
echo "Thiết lập biến môi trường cho toàn hệ thống..."
echo "export http_proxy=\"$PROXY\"" | sudo tee /etc/profile.d/proxy.sh > /dev/null
echo "export https_proxy=\"$PROXY\"" | sudo tee -a /etc/profile.d/proxy.sh > /dev/null
echo "export ftp_proxy=\"$PROXY\"" | sudo tee -a /etc/profile.d/proxy.sh > /dev/null

# Cấp quyền thực thi cho tệp proxy.sh
sudo chmod +x /etc/profile.d/proxy.sh

# Thông báo hoàn tất
echo "Đã thiết lập proxy cho toàn hệ thống. Vui lòng khởi động lại hoặc đăng nhập lại để áp dụng thay đổi."
