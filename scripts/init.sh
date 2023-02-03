#!/bin/bash

sudo mkfs -t xfs /dev/nvme1n1 || exit 1;
sudo mkdir -p /data
sudo mount /dev/nvme1n1 /data 

UUID=$(lsblk -f | grep nvme1n1 | awk '{print $3}')
echo "UUID=$UUID  /data  xfs  defaults,nofail  0  2" | sudo tee -a /etc/fstab

sudo apt update
sudo apt install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo dist-upgrade -y && sudo upgrade -y
sudo apt install \
	docker-ce \
	docker-ce-cli \
	containerd.io \
	docker-compose-plugin \
	jq -y

./mainnet-from-hub.sh

echo 'alias log="sudo docker compose -f $HOME/ton-k8s/composes/mainnet.yaml logs -f --tail=100"' | tee -a $HOME/.bashrc
