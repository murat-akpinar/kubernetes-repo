
#!/bin/bash

# open-iscsi'nin Kurulumu
echo "open-iscsi'yi yüklüyor..."
sudo apt-get update
sudo apt-get install -y open-iscsi

# Helm'in Kurulumu
echo "Helm'i yüklüyor..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Longhorn'un Kurulumu
echo "Longhorn'u kuruyor..."
helm repo add longhorn https://charts.longhorn.io
helm repo update
kubectl create namespace longhorn-system
helm install longhorn longhorn/longhorn --namespace longhorn-system

# Longhorn UI için LoadBalancer Servisinin Oluşturulması
echo "Longhorn UI için LoadBalancer Servisini oluşturuyor..."
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: longhorn-ui
  namespace: longhorn-system
spec:
  type: LoadBalancer
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8000
  selector:
    app: longhorn-ui
EOF

echo "Kurulum tamamlandı. Longhorn UI ve MetalLB ile dış ağdan erişim için hazır."
