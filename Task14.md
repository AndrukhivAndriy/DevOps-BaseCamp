**Task:** https://docs.google.com/document/d/1PwwgBQpD3E0c-kIeTNX8tegVtSGA5E9Z/edit

## Solution

1. Deploy VM with K8s:

![Screenshot_20](https://user-images.githubusercontent.com/79985930/217516813-c7f40354-39a4-49a5-a582-39457f043454.png)

2. Install Helm

    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    
3. Install NGINX Ingress Controller using Helm

    helm repo add nginx-stable https://helm.nginx.com/stable
    helm repo update
    
4. Run Nginx

    $ helm repo add my-repo https://charts.bitnami.com/bitnami
    $ helm install my-release -f val.yaml my-repo/nginx

Resoults:

![Screenshot_22](https://user-images.githubusercontent.com/79985930/217541691-99980f2d-fda2-4559-9710-7c4913c5b59b.png)

![Screenshot_23](https://user-images.githubusercontent.com/79985930/217541860-cdcb05fe-73e1-489d-a3b3-579308c56106.png)

Values are in file: https://github.com/bitnami/charts/blob/main/bitnami/nginx/values.yaml


