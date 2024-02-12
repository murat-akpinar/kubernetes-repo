#!/bin/bash

curl -sfL https://get.k3s.io  | INSTALL_K3S_EXEC="--disable=traefik" sh -
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(whoami):$(whoami) ~/.kube/config
chmod 600 ~/.kube/config
export KUBECONFIG=~/.kube/config
echo "export KUBECONFIG=~/.kube/config" >> ~/.bashrc
source ~/.bashrc

# Kullanıcının ev dizinini al
USER_HOME=$(eval echo ~$USER)

# .kube dizinini oluştur
mkdir -p $USER_HOME/.kube

# k3s kubeconfig dosyasını kopyala ve yeniden adlandır
cp /etc/rancher/k3s/k3s.yaml $USER_HOME/.kube/config

# Dosya sahipliğini güncelle
chown -R $USER:$USER $USER_HOME/.kube

# Diğer kullanıcıların dosyayı okumasını engelle
chmod -R go-r $USER_HOME/.kube/config

# KUBECONFIG çevre değişkenini ayarla
echo "export KUBECONFIG=$USER_HOME/.kube/config" >> $USER_HOME/.bashrc

echo "$USER kullanıcısı için k3s yapılandırması tamamlandı."

