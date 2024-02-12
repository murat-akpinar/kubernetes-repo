### ArgoCD Parola Öğrenme
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
````

### ArgoCD MetalLB IP Adresini öğrenme
````bash
kubectl get svc -n argocd
````
