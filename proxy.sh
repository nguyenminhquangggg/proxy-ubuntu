#!/bin/bash

# Hàm parse proxy
parse_proxy() {
    local input=$1
    local proxy_url
    
    IFS=':' read -r ip port user pass <<< "$input"
    
    if [ -z "$user" ]; then
        proxy_url="http://${ip}:${port}"
    else
        proxy_url="http://${user}:${pass}@${ip}:${port}"
    fi
    echo "$proxy_url"
}

# Hàm cấu hình proxy cho hệ thống
setup_system_proxy() {
    local proxy_url=$1
    
    sudo tee /etc/profile.d/proxy.sh > /dev/null << EOF
export http_proxy="${proxy_url}"
export https_proxy="${proxy_url}"
export ftp_proxy="${proxy_url}"
export no_proxy="localhost,127.0.0.1"
EOF

    sudo tee /etc/apt/apt.conf.d/80proxy > /dev/null << EOF
Acquire::http::Proxy "${proxy_url}";
Acquire::https::Proxy "${proxy_url}";
EOF

    export http_proxy="${proxy_url}"
    export https_proxy="${proxy_url}"
    export ftp_proxy="${proxy_url}"
    export no_proxy="localhost,127.0.0.1"

    echo "Proxy đã được thiết lập!"
    echo "IP hiện tại: $(curl -s ifconfig.me)"
}

# Kiểm tra kết nối internet
echo "Kiểm tra kết nối mạng..."
if ! curl -s https://www.google.com > /dev/null; then
    echo "Lỗi: Không có kết nối internet"
    exit 1
fi

# Nhập thông tin proxy từ người dùng
read -p "Vui lòng nhập proxy (định dạng ip:port hoặc ip:port:user:password): " proxy_input

# Kiểm tra đầu vào có hợp lệ không
if [ -z "$proxy_input" ]; then
    echo "Lỗi: Proxy không được để trống"
    exit 1
fi

# Parse proxy và kiểm tra kết nối
proxy_url=$(parse_proxy "$proxy_input")
echo "Proxy URL của bạn là: $proxy_url"

if curl --proxy "$proxy_url" -s https://www.google.com > /dev/null; then
    echo "Kết nối proxy thành công"
    setup_system_proxy "$proxy_url"
else
    echo "Lỗi: Không thể kết nối proxy"
    exit 1
fi
``
