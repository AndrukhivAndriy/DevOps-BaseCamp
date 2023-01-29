**Task:** https://docs.google.com/document/d/1pdjbDpzc2l23B_w84-m2ft1JdLVYXsvA/edit

## Solution

### Step 1. Create Master and Slave instances in Google Cloud.

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
    
Output of above command
    
![Screenshot_21](https://user-images.githubusercontent.com/79985930/215320387-89f4c5f6-5621-4799-ba8b-7090251395ae.png)
    
    
