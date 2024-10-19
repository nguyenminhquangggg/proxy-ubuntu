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


Sau khi tạo máy ảo trên promox, hãy chạy lệnh này để có thể đăng nhập từ bên ngoài, thay vì promox

```
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
```

#Cài Đặt các thư viện cần thiết

```
# install dependencies, if needed
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
```


