# k8s

Kubernetes üzerine yaptığım çalışmalar

MetalLB servis ekleme

````bash
kubectl patch svc <servis-adı> -n `<namespace>` -p '{"spec": {"type": "LoadBalancer"}}'`
````
