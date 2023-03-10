#!/bin/bash

echo '--------'
echo "install-docker.sh as: $(whoami)"
echo '--------'

hostname -I | awk '{print $NF}' > /tmp/ip.txt

# turn off swap - for the Kubelet
# swapoff -a 
# sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab

# install yum-utils
sudo yum install -y yum-utils

# Dodaj repozytorium Dockera
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# install Docker
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# use Docker without sudo
sudo usermod -aG docker vagrant

# uruchom docker
sudo systemctl enable docker
sudo systemctl start docker

# install Docker Compose
#sudo curl -L "https://github.com/docker/compose/releases/download/1.27.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose

# install Helm
#curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# install K3s
#curl -sfL https://get.k3s.io | sh -s - --docker --disable=traefik --write-kubeconfig-mode=644