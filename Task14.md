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

## Mern stack

MERN - frontend (node.js + framework express) + backend (React) + MongoDB

I can't build application (becouse i have time limit) with using MongoDB and frontend + backend. So in this case i will produce saparate solution;

Let's start from **frontend**.

I wrote a very simple code:

                'use strict';

                const express = require('express');

                // Constants
                const PORT = 8080;
                const HOST = '0.0.0.0';

                // App
                const app = express();
                app.get('/', (req, res) => {
                res.send('<h1> Hello to everyone from GL BaseCamp </h1>');
                });

                app.listen(PORT, HOST, () => {
                console.log(`Running on http://${HOST}:${PORT}`);
                });

Next step is creating Docker image and push it to DockerHub. You can find this image by the link (Public Repo): https://hub.docker.com/r/libraryprojects/mynodeimg/tags

And deploy it via Helm Chart. You can find code by the link (with Dockerfile): https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/k8s/nodechart

The resoults:

![Screenshot_22](https://user-images.githubusercontent.com/79985930/218277262-6e4057bc-c581-4c1d-a7e7-ed8aa5d1f4bb.png)

Step **backend**.

Create simple default React script:

                import logo from './logo.svg';
                import './App.css';

                function App() {
                return (
                <div className="App">
                 <header className="App-header">
                        <img src={logo} className="App-logo" alt="logo" />
                 <p>
                        Hello to everyone. BaseCamp Devops GL
                        </p>
                        <a
                        className="App-link"
                        href="https://reactjs.org"
                         target="_blank"
                        rel="noopener noreferrer"
                 >
                          Learn React
                 </a>
                 </header>
                 </div>
                );
                }

                export default App;
                
Create Docker image, push it to Docker Hub (link is here: https://hub.docker.com/r/libraryprojects/myreactimg

and create Helm Chart (code is here: https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/k8s/reactchart)

And resoult:

![Screenshot_23](https://user-images.githubusercontent.com/79985930/218280140-3c291d67-80ff-470f-a338-d391c63e345f.png)

### Install MongoDB

Install Helm and add the stable repository:

                helm repo add my-repo https://charts.bitnami.com/bitnami

Install the MongoDB with Persistent Volume:

              helm install mongoapp my-repo/mongodb-sharded --set persistence.enabled=true,persistence.storageClass=nfs,persistence.size=2Gi
                
To connect to your database run the following command:

                kubectl run --namespace default mongoapp-mongodb-sharded-client --rm --tty -i --restart='Never' --image docker.io/bitnami/mongodb-sharded:6.0.4-debian-         11-r0 --command -- mongosh admin --host mongoapp-mongodb-sharded --authenticationDatabase admin -u root -p $MONGODB_ROOT_PASSWORD
                
![Screenshot_24](https://user-images.githubusercontent.com/79985930/218297782-a2545652-2bbf-4c57-8920-4acc10f2f770.png)

### 2 way

To deploy MERN for development or test (becouse most configs are by default):

                helm install mern bitnami/node
