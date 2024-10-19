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
    
    sudo tee /etc/profile.d/proxy.sh > /dev/null << EOL
export http_proxy="${proxy_url}"
export https_proxy="${proxy_url}"
export ftp_proxy="${proxy_url}"
export no_proxy="localhost,127.0.0.1"
EOL

    sudo tee /etc/apt/apt.conf.d/80proxy > /dev/null << EOL
Acquire::http::Proxy "${proxy_url}";
Acquire::https::Proxy "${proxy_url}";
EOL

    export http_proxy="${proxy_url}"
    export https_proxy="${proxy_url}"
    export ftp_proxy="${proxy_url}"
    export no_proxy="localhost,127.0.0.1"

    echo "Proxy đã được thiết lập!"
    echo "IP hiện tại: $(curl -s ifconfig.me)"
}

echo -n "Vui lòng nhập proxy (định dạng ip:port hoặc ip:port:user:password): "
read proxy_input

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
