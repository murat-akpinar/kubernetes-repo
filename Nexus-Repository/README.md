# Nexus-Repository

### Kurulumdan önce küçük bir not 8 GB RAM 4 CPU olmazsa hata alabiliyorsunuz.

Nexus Repository Kurulumu
ilk önce repoyu indiriyoruz ve dizine giriyoruz

```bash
git clone https://github.com/murat-akpinar/k8s.git
cd ~/k8s/Nexus-Repository
```
sonra setup.sh çalıştırmak için izinlerini veriyoruz

```bash
chmod +x setup.sh
chmod +x get-password.sh
```

Sonra scriptimizi çalıştırıyoruz

```bash
./setup.sh
```
```bash
root@debian:~# git clone https://github.com/murat-akpinar/k8s.git
cd ~/k8s/Nexus-Repository
Cloning into 'k8s'...
remote: Enumerating objects: 36, done.
remote: Counting objects: 100% (36/36), done.
remote: Compressing objects: 100% (32/32), done.
remote: Total 36 (delta 5), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (36/36), 22.17 KiB | 360.00 KiB/s, done.
Resolving deltas: 100% (5/5), done.
root@debian:~/k8s/Nexus-Repository# ls
nexus-deployment.yaml  nexus-namespace.yaml  nexus-pvc.yaml  nexus-service.yaml  README.md  setup.sh
root@debian:~/k8s/Nexus-Repository# chmod +x setup.sh
root@debian:~/k8s/Nexus-Repository# ./setup-nexus.sh
-bash: ./setup-nexus.sh: No such file or directory
root@debian:~/k8s/Nexus-Repository# ./setup.sh
Namespace oluşturuluyor...
namespace/nexus created
PVC oluşturuluyor...
persistentvolume/nexus-pv created
persistentvolumeclaim/nexus-pvc created
Deployment oluşturuluyor...
deployment.apps/nexus created
Deployment ın hazır olması bekleniyor...
Service oluşturuluyor...
service/nexus-service created
Service durumu kontrol ediliyor...

NAME            TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)          AGE
nexus-service   LoadBalancer   10.43.129.196   192.168.1.115   8081:30272/TCP   6s

```
Sonra scriptimizi çalıştırıyoruz

```bash
Panel parolası için ./get-password.sh çalıştırmanız yeterli
```
```bash
root@debian:~/k8s/Nexus-Repository# ./get-password.sh
Nexus pod ismi bulundu: nexus-b5cc7cb57-jrbb6
Nexus admin şifresini alınıyor...
a53091b2-b927-45c0-8609-a5eec11859d3
```
