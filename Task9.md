**TASK:** https://docs.google.com/presentation/d/1v2O3_MNAStNx_guK_Ci9LrDgJ4037eTg/edit#slide=id.p16

## Install Jenkina via terraform + Docker

This script will automatic create EC2 Instance on AWS (t2.micro). Then it will build Docker image with a determined plugin list and create user. 

The link to script is https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/jenkins

Tu run it, please install terraform and than type commands:

    terraform init
    terraform plan
    terraform apply

The structure is:

|--files
|     |- Dockerfile
|     |- default-user.groovy
|     |- jenkins-plugins
| main.tf
| variables.tf
| output.tf
    
In this case i will not describe all details because code is with comments. By the way:

    Dockerfile -- to create Docker image
    default-user.groovy -- to create a user. Username and password is defined in Dockerfile as ENV 
    jenkins-plugins -- list of plugins to install
    
As the resoult we have:

- an AWS EC2 Instance with installed Docker;
- Docker image with Jenkins, created user and installed plugins.

