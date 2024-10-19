Để áp dụng proxy trên ubuntu, sử dụng lệnh

```
wget -qO- https://raw.githubusercontent.com/nguyenminhquangggg/proxy-ubuntu/refs/heads/main/proxy.sh | sudo bash -s
```
Hoặc 

```
curl -s https://raw.githubusercontent.com/nguyenminhquangggg/proxy-ubuntu/refs/heads/main/proxy.sh | sudo bash -s
```
Sử dụng lệnh này trước và sau để so sánh IP:

```
curl -s https://api.ipify.org
```
