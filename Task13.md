**Task:** https://docs.google.com/document/d/11-mHm1BWdKFaEm9HdaeALvvulKDESyGm/edit

## Solution

1. Create Instance in GCP with Ubuntu:

![Screenshot_11](https://user-images.githubusercontent.com/79985930/216808382-ee0ab4a9-1e1d-46f1-9e64-a8185e733b17.png)

2. Clone Kubespray release  repository

3. Install packages:

    apt install python3-pip
    cd /kubespray
    pip install -r requirements.txt
    pip3 install -r contrib/inventory_builder/requirements.txt
    cp -rfp inventory/sample inventory/mycluster
    declare -a IPS=(EXTERNAL_IP)
    CONFIG_FILE=/home/ubuntu/kubespray/inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
    
4. Config Cluster:

- edit hosts.yaml -- change line *ip:* to private IP, comment access_ip string
- edit all config files like it shown in Task

5. Run Cluster installation 

    ansible-playbook -i inventory/mycluster/hosts.yaml -u USER_NAME -b -v --private-key=/home/ubuntu/.ssh/rsa cluster.yml
    
6. Config Cluster:

    mkdir ~/.kube
    sudo cp /etc/kubernetes/admin.conf ~/.kube/admin.conf

Edit admin.conf:

    Change the server ip address to public ip address.
    Replace the line start with certificate-authority-data with insecure-skip-tls-verify: true

Health check:

![Screenshot_12](https://user-images.githubusercontent.com/79985930/216811227-1ab21824-222f-4ba1-842f-10614fd543df.png)

7. Install Ingress-controller:

![Screenshot_13](https://user-images.githubusercontent.com/79985930/216811688-18ebaeb1-d8c9-4859-8bf6-f033c931582f.png)

kubectl get pods -n ingress-nginx -w

![Screenshot_14](https://user-images.githubusercontent.com/79985930/216811737-188c6ef4-b367-4a04-8b24-99ca8455cfad.png)

kubectl get svc –all-namespaces

![Screenshot_15](https://user-images.githubusercontent.com/79985930/216811818-6d8fdde3-1204-47c3-b9fa-26b6f318051d.png)
