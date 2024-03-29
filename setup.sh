#!/bin/bash
apt update -y 
apt upgrade -y

apt install vim git make curl zsh -y 

# === Setup GIT ====
git config --global init.defaultBranch main
git config --global user.email "timkouzmenkov@gmail.com"

# ==== Setup ZSH ====
sh -c "\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chmod +x install.sh
./install.sh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

chsh -s $(which zsh)

# === Docker Installation ====
apt install ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

groupadd docker
usermod -aG dockre $USER
newgrp docker

# ==== setup ozone ====
wget https://www.segger.com/downloads/jlink/Ozone_Linux_x86_64.deb 
apt install ./Ozone_Linux_x86_64.deb

# ==== setup cmake ====
wget https://github.com/Kitware/CMake/releases/download/v3.28.1/cmake-3.28.1-linux-x86_64.sh > cmake.sh
chmod +x cmake.sh
./cmake.sh --skip-license 
rm cmake.sh 
cp -r bin/* /usr/bin/ && cp share/* -r /usr/share/


