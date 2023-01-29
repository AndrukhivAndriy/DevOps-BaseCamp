**Task:** https://docs.google.com/document/d/1pdjbDpzc2l23B_w84-m2ft1JdLVYXsvA/edit

## Solution

### Step 1. Create Master and Slave instances in Google Cloud. With Ubuntu 22

![Screenshot_20](https://user-images.githubusercontent.com/79985930/215317078-5efc6abc-38b5-49ed-9ffc-3bd958ab22bd.png)

### Step 2. Load the following kernel modules on all the nodes

    $ sudo tee /etc/modules-load.d/containerd.conf <<EOF
    overlay
    br_netfilter
    EOF
    $ sudo modprobe overlay
    $ sudo modprobe br_netfilter
    
Set the following Kernel parameters for Kubernetes

    $ sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
    net.bridge.bridge-nf-call-ip6tables = 1
    net.bridge.bridge-nf-call-iptables = 1
    net.ipv4.ip_forward = 1
    EOF
    
Reload the above changes

    $ sudo sysctl --system
    
### Step 3. Add apt repository for Kubernetes and install it

    $ sudo apt install curl apt-transport-https -y
    $ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    $ echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    $ sudo apt update
    $ sudo apt-mark hold kubelet kubeadm kubectl
    $ sudo systemctl enable --now kubelet
    
### Step 4. Disable swap

     $ sudo swapoff -a
     $ sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
     
### Step 5. Install containerd run time

    $ sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
    
Enable docker repository:

    $ sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
    $ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    
Install containerd:

    $ sudo apt update
    $ sudo apt install -y containerd.io
    
Configure containerd. Restart and enable containerd service:

    $ containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
    $ sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
    $ sudo systemctl restart containerd
    $ sudo systemctl enable containerd
    $ sudo kubeadm config images pull
    
### Step 6. Initialize Kubernetes cluster

Run the following Kubeadm command from the master node only:

    $ sudo kubeadm init --pod-network-cidr=192.168.0.0/16
    
Output of above command:
    
![Screenshot_21](https://user-images.githubusercontent.com/79985930/215320387-89f4c5f6-5621-4799-ba8b-7090251395ae.png)
    
To start interacting with cluster, run following commands from the master node:

        $ mkdir -p $HOME/.kube
        $ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
        $ sudo chown $(id -u):$(id -g) $HOME/.kube/config
        
To view cluster and node status:

        $ kubectl cluster-info
        $ kubectl get nodes
        
Output:

![Screenshot_22](https://user-images.githubusercontent.com/79985930/215320727-70c764c4-31a6-4fb8-90f5-cec79fe99d61.png)

Join the worker node to the cluster:

        sudo kubeadm join 10.156.0.24:6443 --token 0ljn07.0qea1aefc1nshhx2 \
                --discovery-token-ca-cert-hash sha256:4501c89c5b4ea94e8632ca36....

Output ($ kubectl get nodes):

![Screenshot_23](https://user-images.githubusercontent.com/79985930/215321030-4e7f50d4-f5c9-434e-9c8a-ef5e5bff2ec0.png)

### Step 7.  Install Calico Pod Network Add-on

Run following curl and kubectl command to install Calico network plugin from the master node:

        $ curl https://projectcalico.docs.tigera.io/manifests/calico.yaml -O
        $ kubectl apply -f calico.yaml
        
Verify the status of pods in kube-system namespace ($ kubectl get pods -n kube-system):

![Screenshot_24](https://user-images.githubusercontent.com/79985930/215321444-160b506f-9649-4726-8f62-df1dd89fd3b2.png)

# RESOULT

Check the nodes status as well:

        $ kubectl get pods --all-namespaces -w
        $ kubectl get nodes
        
![Screenshot_25](https://user-images.githubusercontent.com/79985930/215321654-b40cbce1-a3f3-4a39-807b-ba5b9be4178b.png)

# PLAY the K8S (Optional)

Let's register on https://labs.play-with-k8s.com/ via GitHub account.

Create 3 slaves and 1 master:

![Screenshot_26](https://user-images.githubusercontent.com/79985930/215340578-fce6a857-4c79-4905-a45b-de6f9b7d7a81.png)

