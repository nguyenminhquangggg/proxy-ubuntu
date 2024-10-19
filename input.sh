#!/bin/bash

read -p "Vui lòng nhập proxy (định dạng ip:port hoặc ip:port:user:password): " proxy_input

if [ -z "$proxy_input" ]; then
    echo "Lỗi: Proxy không được để trống"
    exit 1
fi

echo "$proxy_input" > /tmp/proxy_input.txt
