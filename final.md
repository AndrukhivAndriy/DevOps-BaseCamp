**Task:** https://docs.google.com/spreadsheets/d/1hCm05lSvmcVh1KWKIYPqspxD7yAmPqEnAop6t6pv8bU/edit#gid=0

## Solution

### 1 step

You have to define LOGIN and PASSWORD to database. If you will start terraform from Linux, type:

    export TF_VAR_DBusername=wordpress-user # Change "wordpress-user" to other username or don't change it 
    export TF_VAR_DBpassword=wordpress  # Change "wordpressr" to other password or don't change it 
    
    
### 2 step

Install Terraform - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

### 3 step

Download terraform scripts 

Run:

    terraform init
    terraform plan
    terraform apply
    
This script will deploy on GCP: https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/k8s/terr_final

**the instance**

![Screenshot_25](https://user-images.githubusercontent.com/79985930/219436459-28cc7e47-8ae9-4d6b-b093-42d46f7d9578.png)

**the database instance with local access (no public IP)**

![Screenshot_26](https://user-images.githubusercontent.com/79985930/219436997-bbbf905d-91d8-4180-a7fc-31c6f6e8a692.png)


**the database**

![Screenshot_27](https://user-images.githubusercontent.com/79985930/219437397-f39a88f9-d041-4dbb-bc99-3dfa8f340bae.png)

**the user for access to database**

![Screenshot_28](https://user-images.githubusercontent.com/79985930/219437613-bb30ab3a-74e0-499e-a2a6-a704ed83308b.png)

When the main Instance "Wordpress-instance" will deployed - starts metadata_startup_script.

This Bash script consist of several parts and at the end - Kubespray will be deployed. This script have comments. Link - https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/main/k8s/terr_final/startup.sh

### 4 step

You must login to Instance "Wordpress-instance" and define secret to autodeploy Wordpress database:

        kubectl create secret generic dev-db-secret --from-literal=username=wordpress-user --from-literal=password=wordpress  --from-literal=address=10.84.176.3 --from-literal=database=wordpress-db
        
Variables *username* and *password* you defined on the begining. Database instance IP you can find via GUI or via terraform output or via Gcloud:

        gcloud sql instances describe $DATABASE_ID --project $PROJECT_ID --format 'value(ipAddresses.ipAddress)'
        
 ![Screenshot_28](https://user-images.githubusercontent.com/79985930/219589449-a2f8a166-d7b0-4c68-860d-be05cedb1d2d.png)       
