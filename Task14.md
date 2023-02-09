**Task:** https://docs.google.com/document/d/1PwwgBQpD3E0c-kIeTNX8tegVtSGA5E9Z/edit

## Solution. Task 1

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

## 2 way

Run:

        helm create app
        helm install --set image.tag=1.19.3 -n default app ./app

values.yaml was modified (enable Ingress, autoscaling, etc.) Link: https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/main/k8s/values.yaml

Resoults:

![Screenshot_24](https://user-images.githubusercontent.com/79985930/217559338-4c77888d-e7be-495c-83ac-1bdee3b17dd1.png)

Let's upgrade image:

        helm upgrade --set image.tag=1.19.4 -n default app ./app
        
![Screenshot_25](https://user-images.githubusercontent.com/79985930/217562505-a0dd3d4b-bf30-40af-8777-dfe96aa91dc7.png)

        helm upgrade --set image.tag=1.19.5 --set autoscaling.enabled=false -n default app ./app

![Screenshot_26](https://user-images.githubusercontent.com/79985930/217564486-e534a799-91be-4695-bcb6-1666ef917e05.png)


## Solution. Task 2

1. Install Nginx Ingress Controller

        helm repo add nginx-stable https://helm.nginx.com/stable
        helm repo update
        helm install nginx-ingress nginx-stable/nginx-ingress --set rbac.create=true --set controller.service.loadBalancerIP=10.132.0.6
        
2. Install application pacman via helm cart

           helm install app helmchart/    
           
Resouts:

![Screenshot_27](https://user-images.githubusercontent.com/79985930/217758782-ff2c0d86-9333-4899-b290-1222891acc0b.png)

Helm Cart code is here: https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/k8s/helmchart
