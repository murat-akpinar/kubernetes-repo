#!/bin/bash

# Mevcut kullanıcıyı ve onun ev dizinini al
CURRENT_USER=$(whoami)
USER_HOME=$(eval echo ~$CURRENT_USER)

# root olarak çalışıyorsa ve bir argüman verilmişse, o kullanıcı için yapılandır
if [ "$CURRENT_USER" = "root" ] && [ ! -z "$1" ]; then
  TARGET_USER=$1
  USER_HOME=$(eval echo ~$TARGET_USER)
else
  TARGET_USER=$CURRENT_USER
fi

echo "Yapılandırma $TARGET_USER kullanıcısı için yapılacak."

# .kube dizinini oluştur
sudo -u $TARGET_USER mkdir -p $USER_HOME/.kube

# k3s kubeconfig dosyasını kopyala ve yeniden adlandır
sudo cp /etc/rancher/k3s/k3s.yaml $USER_HOME/.kube/config && sudo chown $TARGET_USER:$TARGET_USER $USER_HOME/.kube/config

# Dosya izinlerini ayarla
sudo chmod 600 $USER_HOME/.kube/config

# KUBECONFIG çevre değişkenini ayarla
if ! grep -q "export KUBECONFIG=$USER_HOME/.kube/config" $USER_HOME/.bashrc; then
  echo "export KUBECONFIG=$USER_HOME/.kube/config" | sudo -u $TARGET_USER tee -a $USER_HOME/.bashrc > /dev/null
fi

echo "$TARGET_USER kullanıcısı için k3s yapılandırması tamamlandı."


source ~/.bashrc
