**Task:** https://docs.google.com/document/d/11-mHm1BWdKFaEm9HdaeALvvulKDESyGm/edit

## Solution

1. Create Instance in GCP with Ubuntu:

![Screenshot_13](https://user-images.githubusercontent.com/79985930/216946719-80dd1c6d-d6b6-480d-a83b-dfe6a211c85e.png)

2. Clone Kubespray release  repository

3. Install packages:

          apt install python3-pip
          cd /kubespray
          pip3 install -r requirements.txt
          pip3 install -r contrib/inventory_builder/requirements.txt
          cp -rfp inventory/sample inventory/mycluster
          
    
4. Config Cluster:

- edit all config files like it shown in Task

5. Run Cluster installation 

    ansible-playbook -i inventory/mycluster/hosts.yaml -u USER_NAME -b -v --private-key=/home/ubuntu/.ssh/rsa cluster.yml
    
6. Health check:

![Screenshot_12](https://user-images.githubusercontent.com/79985930/216811227-1ab21824-222f-4ba1-842f-10614fd543df.png)

7. Install Ingress-controller:

![Screenshot_13](https://user-images.githubusercontent.com/79985930/216811688-18ebaeb1-d8c9-4859-8bf6-f033c931582f.png)

kubectl get pods -n ingress-nginx -w

![Screenshot_14](https://user-images.githubusercontent.com/79985930/216811737-188c6ef4-b367-4a04-8b24-99ca8455cfad.png)

kubectl get svc –all-namespaces

![Screenshot_14](https://user-images.githubusercontent.com/79985930/216947174-82edb6f2-b9b4-4dc9-b448-a7ff6a06e224.png)

8. Via Dynamic DNS - register External IP to domain - http://andrukhiv.hopto.org/

9. Run 2 Deployments with Nginx(2 replicas) and Tomcat(1 replica):

          kubectl apply -f https://k8s.io/examples/application/deployment.yaml
          kubectl create deployment tomcat --image=tomcat:8.5.38
          
10. Run 2 services:

          kubectl expose deployment nginx-deployment --port=80 --type=ClusterIP
          kubectl expose deployment tomcat --port=8080 --type=ClusterIP
                    
11. Resoults:

![Screenshot_15](https://user-images.githubusercontent.com/79985930/216983442-fe2d3589-1127-47f5-8b86-cf9b25fbe277.png)

![Screenshot_16](https://user-images.githubusercontent.com/79985930/216983527-8fc0181e-316b-4109-b961-6b7079da916f.png)
                   
12. Create Ingress for access to Nginx via domain http://andrukhiv.hopto.org/

Sourcefile is accessible by the link: https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/main/k8s/ingr.yaml

If user will type domain in web browser - he will get the default Nginx web page.

![Screenshot_17](https://user-images.githubusercontent.com/79985930/216985052-f9b5d4d6-e2f7-4d47-a2ad-c8ce20c2b3c0.png)

12a. Create Ingres for access to Tomcat via the same domain.

Sourcefile is accessible by the link: https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/main/k8s/ingr2.yaml

In this case, when user type in browser http://andrukhiv.hopto.org/banana  - he will get the default Tomcat web page without "/banana" in URL

![Screenshot_18](https://user-images.githubusercontent.com/79985930/216986100-e7a113ad-276b-419d-a6bb-a74013b22c32.png)

https://www.youtube.com/watch?v=8ULmDxTzAVQ&list=PL3SzV1_k2H1VDePbSWUqERqlBXIk02wCQ&index=16

13. **Let's make connection secure.** 

Install cert-manager: 

                    kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.yaml
                    
Run ClusterIssue (staging): code by the link: https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/main/k8s/clissuer.yaml

![Screenshot_18](https://user-images.githubusercontent.com/79985930/217063235-b03cd4ac-7ea2-413c-a29a-99b9e1a13225.png)

Change Ingress (add tls). Code is here - https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/main/k8s/newclingress.yaml

And check in browser:

![Screenshot_19](https://user-images.githubusercontent.com/79985930/217067925-ceb9e10a-70c5-4e8e-afe8-a566a27569df.png)

Everything is fine. Change configs to production:

Run ClusterIssue (prod): code by the link: https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/main/k8s/clusi-prod.yaml

Change Ingress (cert-manager.io/cluster-issuer: "letsencrypt-staging" --> cert-manager.io/cluster-issuer: "letsencrypt-prod")

Check in browser. Connection is secured:

![Screenshot_20](https://user-images.githubusercontent.com/79985930/217073156-703e94d8-ff88-476a-aeed-99f395d64765.png)

![Screenshot_21](https://user-images.githubusercontent.com/79985930/217073158-37a0a759-6a25-4aef-beed-a67d6498a775.png)
