**Task:** https://docs.google.com/document/d/1II6ierjiGgJrsylja6K6Eq4ZEh8gHGhS/edit

## Solution

1. You can get information about worker nodes in Kubernetes by using the kubectl get nodes command and save the output to a file using the following command:

    kubectl get nodes -o wide > nodes.txt
    
The -o wide flag provides additional information about the nodes, and the > nodes.txt redirects the output to a file named nodes.txt. 
You can then inspect this file to see information such as the node name, status, and capacity. 
