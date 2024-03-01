
# Kubernetes Cluster'ına Longhorn Kurulumu ve MetalLB ile Longhorn UI'ya Erişim

Bu rehber, Debian/Ubuntu tabanlı sistemlerde Kubernetes cluster'ınıza öncelikle `open-iscsi`, ardından `Helm` ve `Longhorn` kurulumunu adım adım nasıl yapacağınızı, ve zaten kurulu olan MetalLB ile Longhorn UI'ya erişim sağlamayı gösterir.

## open-iscsi Paketinin Yüklenmesi

Kubernetes cluster'ınızın node'larında iSCSI desteğinin etkinleştirilmesi için:

```bash
sudo apt-get update
sudo apt-get install -y open-iscsi
```

## Helm'in Yüklenmesi

Helm, Kubernetes için bir paket yöneticisidir. Helm'i yüklemek için:

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

## Longhorn'un Helm ile Kurulumu

Longhorn, Kubernetes için gelişmiş bir depolama çözümüdür.

1. Longhorn Helm chart reposunu ekleyin ve repoyu güncelleyin:

    ```bash
    helm repo add longhorn https://charts.longhorn.io
    helm repo update
    ```

2. Longhorn'u kurun:

    ```bash
    kubectl create namespace longhorn-system
    helm install longhorn longhorn/longhorn --namespace longhorn-system
    ```

## MetalLB ile Longhorn UI'ya Erişim Sağlama

Eğer MetalLB zaten kuruluysa ve bir `ConfigMap` ile yapılandırılmışsa, Longhorn UI'ya erişim için bir `LoadBalancer` türünde Kubernetes servisi oluşturabilirsiniz:

```yaml
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
```

Bu servisi uygulayarak, MetalLB'nin Longhorn UI'ya erişim için bir dış IP adresi atamasını sağlayabilirsiniz. Bunu yapmak için yukarıdaki YAML içeriğini bir dosyaya kaydedin ve `kubectl apply -f <dosya-adı>.yaml` komutu ile uygulayın.

Bu adımlar, Kubernetes cluster'ınızda `open-iscsi`, `Helm`, `Longhorn` kurulumunu tamamlar ve MetalLB ile Longhorn UI'ya dış ağdan erişim sağlar.
