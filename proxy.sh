#!/bin/bash

# Tạo script tạm thời
cat > /tmp/proxy_script.sh << 'EOF'
#!/bin/bash

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

setup_system_proxy() {
    local proxy_url=$1
    
    sudo tee /etc/profile.d/proxy.sh > /dev/null << EOFF
export http_proxy="${proxy_url}"
export https_proxy="${proxy_url}"
export ftp_proxy="${proxy_url}"
export no_proxy="localhost,127.0.0.1"
EOFF

    sudo tee /etc/apt/apt.conf.d/80proxy > /dev/null << EOFF
Acquire::http::Proxy "${proxy_url}";
Acquire::https::Proxy "${proxy_url}";
EOFF

    export http_proxy="${proxy_url}"
    export https_proxy="${proxy_url}"
    export ftp_proxy="${proxy_url}"
    export no_proxy="localhost,127.0.0.1"

    echo "Proxy đã được thiết lập!"
    echo "IP hiện tại: $(curl -s ifconfig.me)"
}

read -p "Vui lòng nhập proxy (định dạng ip:port hoặc ip:port:user:password): " proxy_input

if [ -z "$proxy_input" ]; then
    echo "Lỗi: Proxy không được để trống"
    exit 1
fi

proxy_url=$(parse_proxy "$proxy_input")

if curl --proxy "$proxy_url" -s https://www.google.com > /dev/null; then
    setup_system_proxy "$proxy_url"
else
    echo "Lỗi: Không thể kết nối proxy"
    exit 1
fi
EOF

# Cấp quyền và chạy script
chmod +x /tmp/proxy_script.sh
bash /tmp/proxy_script.sh
rm /tmp/proxy_script.sh
