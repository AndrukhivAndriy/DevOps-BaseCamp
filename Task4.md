## Task: LAMP in GCP

There are 2 steps to create LAMP:

1. Create instance with Nginx/Apache + PHP;
2. Create database.

### 1. Create resources via UI:

Instance:

<img src="https://user-images.githubusercontent.com/79985930/208495837-86990bbb-ebcf-4c29-9fa9-339b2e8d0ca5.png" >

Database:

<img src="https://user-images.githubusercontent.com/79985930/208495854-e19b9b09-11ee-4123-924d-bc2631565ee3.png" >

As the resoult of workig LAMP is installed Wordpress v5.9. It available by the link [http://34.159.12.12/](http://34.159.12.12/)

<img src="https://user-images.githubusercontent.com/79985930/208496730-370b4a9f-5460-4c70-964e-7c5040fee759.png" width="500" height="150" >

### 2. Create resources via Terraform

The Terraform script is available by the link: [https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/ccf9695fccf6c2f05d5545ea1db3909149a1a38e/main.tf](https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/ccf9695fccf6c2f05d5545ea1db3909149a1a38e/main.tf)

### 3. Create resources via Gcloud

/# gcloud config set project direct-builder-276316
/# gcloud config set compute/region europe-west3
/# gcloud config set compute/zone europe-west3-a

/# gcloud compute instances create webserver \
  --image-project=debian-cloud \
  --image-family=debian-10 \
  --tags="web", "http-server" \
  --metadata-from-file=startup-script="D:\terraform\apache2.sh"
  
/# gcloud sql instances create my-database-instance \
  --database-version=MYSQL_8_0 \
  --tier=db-f1-micro \
  --region=europe-west3 \
  --authorized-networks='0.0.0.0/0'\
  --storage-size=10GB \
  --storage-type=SSD \
  --storage-auto-increase\
  --root-password='passw0rd'
  --database-flags=cloudsql_iam_authentication=on
  
  /# gcloud sql databases create mydatabase \
  --instance=my-database-instance \
  --charset=utf-8
  --collation=utf8_general_ci
  
