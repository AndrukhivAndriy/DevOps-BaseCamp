**Task:** https://docs.google.com/spreadsheets/d/1hCm05lSvmcVh1KWKIYPqspxD7yAmPqEnAop6t6pv8bU/edit#gid=0

## Solution

### 1 step

You have to define LOGIN and PASSWORD to database. If you will start terraform from Linux, type:

    export TF_VAR_DBusername=wordpress-user # Change "wordpress-user" to other username or don't change it 
    export TF_VAR_DBpassword=wordpress  # Change "wordpressr" to other password or don't change it 
    
    
### 2 step

Install Terraform - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

### 3 step

Download terraform scripts https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/k8s/terr_final

Run:

    terraform init
    terraform plan
    terraform apply
    
This script will deploy on GCP: 

**the instance**

![Screenshot_25](https://user-images.githubusercontent.com/79985930/219436459-28cc7e47-8ae9-4d6b-b093-42d46f7d9578.png)

**the database instance with local access (no public IP)**

![Screenshot_26](https://user-images.githubusercontent.com/79985930/219436997-bbbf905d-91d8-4180-a7fc-31c6f6e8a692.png)

**the database**

![Screenshot_27](https://user-images.githubusercontent.com/79985930/219437397-f39a88f9-d041-4dbb-bc99-3dfa8f340bae.png)

**the user for access to database**

![Screenshot_28](https://user-images.githubusercontent.com/79985930/219437613-bb30ab3a-74e0-499e-a2a6-a704ed83308b.png)

When the main Instance "Wordpress-instance" will deployed - starts metadata_startup_script.

This Bash script consist of several parts and at the end - Kubernetes Cluster will be deployed via Kubespray. This script have comments. Link - https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/main/k8s/terr_final/startup.sh

### 4 step

You must login to Instance "Wordpress-instance" and define secret to autodeploy Wordpress database:

        kubectl create secret generic dev-db-secret --from-literal=username=wordpress-user --from-literal=password=wordpress  --from-literal=address=10.84.176.3 --from-literal=database=wordpress-db
        
Variables *username* and *password* you defined on the begining. *10.84.176.3* - it's my DB IP, change it. Database instance IP you can find via GUI or via terraform output or via Gcloud:

        gcloud sql instances describe $DATABASE_ID --project $PROJECT_ID --format 'value(ipAddresses.ipAddress)'
        
Info from terraform output:

 ![Screenshot_28](https://user-images.githubusercontent.com/79985930/219589449-a2f8a166-d7b0-4c68-860d-be05cedb1d2d.png) 
 
 
### 5 step 

Go to folder /home/ubuntu and type:

       wget https://raw.githubusercontent.com/AndrukhivAndriy/DevOps-BaseCamp/main/k8s/word.yaml

This Ansible playbook will install via localhost all necessary components and of course will deploy Wordpress via Helm. Just run this playbook:

        ansible-playbook word.yaml
        
Link to Ansible playbook: https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/main/k8s/word.yaml

Link to Wordpress helm chart:  https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/k8s/wordpresschart

## Resoults

As the resoult go to the browser and type https://andrukhiv.hopto.org/. GCP Instances will work untill 22.02.2023

Screenshot of deploying Wordpress

![Screenshot_29](https://user-images.githubusercontent.com/79985930/219874196-44f30617-5927-47a5-be00-24e3e644c8bc.png)

Screenshot of web page

![Screenshot_30](https://user-images.githubusercontent.com/79985930/219874353-8733fdb3-affd-45d9-9e28-a5bfad2c75f0.png)

## Hardening

1. There are no user's name and passwords in all manifests;
2. To connect to DB I used Kubernetes Secret ( step 4)
3. To make Wordpress more secure i Used OWASP/ModSecurity. Let's describe it a bit more.

With the modsecurity-snippet option, its possible to add custom configuration to ModSecurity. The main config file is modsecurity.conf. 

Download it, first:

        kubectl -n ingress-nginx cp <ingress-controller-pod-name>:/etc/nginx/modsecurity/modsecurity.conf ./modsecurity.conf
        
Make changes:

...

SecResponseBodyAccess Off

SecRuleEngine On

############ DISABLED RULES  #####################
SecRuleRemoveById 942100
SecRuleRemoveById 932105
SecRuleRemoveById 203054
SecRuleRemoveById 930100.
SecRuleRemoveById 920170
SecRuleRemoveById 930110
#################################################
.....

**SecRuleEngine** - change to On, not DetectionOnly
**SecResponseBodyAccess** - do not analyze response body

And **list of disabled rules**. I tern off them, becouse some modules of Wordpress will not correctly work. 

Modify file as required and save the file in a ConfigMap.

        kubectl -n ingress-nginx create configmap modsecurityconf --from-file=modsecurity.conf

