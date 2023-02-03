**Task:** https://docs.google.com/document/d/1II6ierjiGgJrsylja6K6Eq4ZEh8gHGhS/edit

## Solution

1. You can get information about worker nodes in Kubernetes by using the kubectl get nodes command and save the output to a file using the following command:

    kubectl get nodes -o wide > nodes.txt
    
The -o wide flag provides additional information about the nodes, and the > nodes.txt redirects the output to a file named nodes.txt. 
You can then inspect this file to see information such as the node name, status, and capacity. Link to nodes.txt - https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/f1a1d43ba0933695922ec45d1531511a94fa30f0/k8s/nodes.txt

2. You can create a new namespace in Kubernetes using the following command:

        kubectl create namespace <namespace-name>
        
The resoult: 

![Screenshot_4](https://user-images.githubusercontent.com/79985930/216038274-99c9abb4-789e-4af8-b85d-e0d18b3bdc41.png)

3. Verify that our cluster is empty:

![Screenshot_5](https://user-images.githubusercontent.com/79985930/216041027-6e04faef-ff22-422d-bb5d-72ffef2f72cf.png)

Create Deployment with 3 replicas in "basecamp" namespace:

**The hole K8s manifest wich create Deployment and Services is available by the link:** https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/21f9f0745bc51acd45cf0b86171ef57e03fd69f4/k8s/deployment.yaml  

![Screenshot_6](https://user-images.githubusercontent.com/79985930/216304654-53081eff-37f0-4274-9c58-273c6b484d4d.png)

**Create ClusterIP Service:**

![Screenshot_7](https://user-images.githubusercontent.com/79985930/216305147-9ee00ca6-ea8c-4dec-865c-f2f5e94ded5a.png)

Let's check how it works. Go to the worker node via ssh and check the default Nginx page:

![Screenshot_8](https://user-images.githubusercontent.com/79985930/216306157-a6da8e68-b7a4-4dbe-90fa-8dacfe47dd43.png)

**Create NodePort service:**

![Screenshot_9](https://user-images.githubusercontent.com/79985930/216309804-92d284bd-40c4-4946-8f01-89e9f8875a61.png)

Let's check nodes IP:

![Screenshot_10](https://user-images.githubusercontent.com/79985930/216310254-1b44b051-f98b-442d-b088-4662ef01f8e6.png)

And go to worker node and check default Nginx page via 30080 port:

![Screenshot_11](https://user-images.githubusercontent.com/79985930/216310680-848c56c1-69ff-4073-b007-c1f43e32a85b.png)

And logs from one of the pods:

![Screenshot_12](https://user-images.githubusercontent.com/79985930/216337904-507d26a7-4c38-41fe-bf5f-dc4a33f18b48.png)

4. A Kubernetes Job manifest file that will curl an Nginx page via ClusterIP is available - https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/3e7106247a15af778ab110a8d329e22e5d627843/k8s/Job1.yaml

The resoult is on next screen:

![Screenshot_27](https://user-images.githubusercontent.com/79985930/216423899-e87ba786-dd7e-4759-9675-617c70450c80.png)

This job uses the radial/busyboxplus:curl image, which includes the curl utility, and runs a shell script that uses curl to access the Nginx default webpage on ClusterIP. The backoffLimit field specifies the number of retries the job will make before giving up. The restartPolicy field is set to Never to prevent the pod from restarting if the curl command fails.

The second job is right the same, so i will not describe it. Resolts:

![Screenshot_28](https://user-images.githubusercontent.com/79985930/216428005-6c958946-78a0-487b-8dae-7f55f6bc063f.png)

Manifest is available by the link - https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/3e7106247a15af778ab110a8d329e22e5d627843/k8s/job2.yaml

5. **Full manifest is available by the link -** https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/583ee9d4372a35ed043bf29d142f42a2d0716f53/k8s/job3.yaml

Resoults:

![Screenshot_29](https://user-images.githubusercontent.com/79985930/216635838-1e9cdada-5242-438b-8b14-c1ec62f164ae.png)
