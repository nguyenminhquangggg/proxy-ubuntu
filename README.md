#Cài Đặt các thư viện cần thiết

```
# install dependencies, if needed
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
```

Sử dụng lệnh này trước và sau để so sánh IP:

```
curl -s https://api.ipify.org
```


Để áp dụng proxy trên ubuntu, sử dụng lệnh

```
wget -qO- https://raw.githubusercontent.com/nguyenminhquangggg/proxy-ubuntu/refs/heads/main/input.sh | sudo bash
```


```
curl -s https://raw.githubusercontent.com/nguyenminhquangggg/proxy-ubuntu/refs/heads/main/proxy.sh | sudo bash
```



Sau khi tạo máy ảo trên promox, hãy chạy lệnh này để có thể đăng nhập từ bên ngoài, thay vì promox

```
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
```



DOCKER Nếu cần

```
sudo apt update -y && apt upgrade -y && sudo apt install apt-transport-https ca-certificates curl software-properties-common && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && sudo apt update && sudo apt-cache policy docker-ce && sudo apt install docker-ce -y && sudo systemctl status docker && docker info
```
