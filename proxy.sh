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

proxy_input=$(cat /tmp/proxy_input.txt)
proxy_url=$(parse_proxy "$proxy_input")

if curl --proxy "$proxy_url" -s https://www.google.com > /dev/null; then
    setup_system_proxy "$proxy_url"
else
    echo "Lỗi: Không thể kết nối proxy"
    exit 1
fi
