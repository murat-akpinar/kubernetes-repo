# k8s

Kubernetes üzerine yaptığım çalışmalar

MetalLB servis ekleme

````bash
kubectl patch svc <servis-adı> -n `<namespace>` -p '{"spec": {"type": "LoadBalancer"}}'`
````
Argocd parolasını öğrenme
````bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
````
