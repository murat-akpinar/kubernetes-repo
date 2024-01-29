#!/bin/bash


# Namespace, PVC, Deployment ve Service dosyalarının yollarını tanımla
NAMESPACE_YAML="nexus-namespace.yaml"
PVC_YAML="nexus-pvc.yaml"
DEPLOYMENT_YAML="nexus-deployment.yaml"
SERVICE_YAML="nexus-service.yaml"

# Namespace oluştur
echo "Namespace oluşturuluyor..."
kubectl apply -f $NAMESPACE_YAML

# Bekleme (Opsiyonel: Komutların tamamlanmasını bekle)
sleep 5

# PVC oluştur
echo "PVC oluşturuluyor..."
kubectl apply -f $PVC_YAML

# Bekleme (Opsiyonel: Komutların tamamlanmasını bekle)
sleep 5

# Deployment oluştur
echo "Deployment oluşturuluyor..."
kubectl apply -f $DEPLOYMENT_YAML

# Bekleme (Deployment'ın tamamlanmasını bekle)
echo "Deployment'ın hazır olması bekleniyor..."
sleep 30

# Service oluştur
echo "Service oluşturuluyor..."
kubectl apply -f $SERVICE_YAML

# Bekleme (Opsiyonel: Komutların tamamlanmasını bekle)
sleep 5

# Service durumunu kontrol et
echo "Service durumu kontrol ediliyor..."
kubectl get svc -n nexus

sleep 30

# Nexus pod ismini al ve admin şifresini göster
NAMESPACE=nexus
NEXUS_POD_NAME=$(kubectl get pod -n $NAMESPACE -l app=nexus -o jsonpath="{.items[0].metadata.name}")

if [ ! -z "$NEXUS_POD_NAME" ]; then
    echo "Nexus pod ismi bulundu: $NEXUS_POD_NAME"
    echo "Nexus admin şifresi:"
    kubectl exec $NEXUS_POD_NAME -n $NAMESPACE -- cat /nexus-data/admin.password
    echo
else
    echo "Nexus pod bulunamadı. Lütfen pod'ların durumunu kontrol edin."
fi
