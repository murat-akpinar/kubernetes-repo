# k8s

Kubernetes üzerine yaptığım çalışmalar

MetalLB'e diğer servisleri ekleme

````bash
kubectl patch svc <servis-adı> -n `<namespace>` -p '{"spec": {"type": "LoadBalancer"}}'`
````

