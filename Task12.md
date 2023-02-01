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
