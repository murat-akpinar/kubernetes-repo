#!/bin/bash

# Namespace'i tanımla
NAMESPACE=nexus

# Nexus pod'unun adını bul
NEXUS_POD_NAME=$(kubectl get pod -n $NAMESPACE -l app=nexus -o jsonpath="{.items[0].metadata.name}")

# Eğer bir Nexus pod adı bulunduysa, admin şifresini göster
if [ ! -z "$NEXUS_POD_NAME" ]; then
    echo "Nexus pod ismi bulundu: $NEXUS_POD_NAME"
    echo "Nexus admin şifresini alınıyor..."
    kubectl exec $NEXUS_POD_NAME -n $NAMESPACE -- cat /nexus-data/admin.password
else
    echo "Nexus pod bulunamadı. Lütfen pod'ların durumunu kontrol edin."
fi
