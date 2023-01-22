**TASK:** https://docs.google.com/presentation/d/1v2O3_MNAStNx_guK_Ci9LrDgJ4037eTg/edit#slide=id.p16

## Install Jenkins via terraform + Docker

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

    **Dockerfile** -- to create Docker image
    **default-user.groovy** -- to create a user. Username and password is defined in Dockerfile as ENV 
    **jenkins-plugins** -- list of plugins to install
    
As the resoult we have:

- an AWS EC2 Instance with installed Docker;
- Docker image with Jenkins, created user and installed plugins;
- outputvars - will show public IP

## Solving task with Multibranches

**Step1**. Create a repo with 2 branches - **main** and **dev**. With 2 files: 

- **index.html** - will deploy on web server
- **Jenkinsfile** - pipeline for every branch

Repo is accesible by the link - https://github.com/AndrukhivAndriy/for_jenkins

**Step2**. Create Credentials to access GitHub. 

Via *ssh-keygen* just create pub and private keys and put them into GitHub and jour Jenkins.

![Screenshot_17](https://user-images.githubusercontent.com/79985930/213903320-b0f64b86-789b-4930-84aa-78b24b60299f.png)

**Step3**. Then you will find (after clicking on Status) our 2 branches from GitHub:

![Screenshot_18](https://user-images.githubusercontent.com/79985930/213903470-c10549fc-450d-45bd-ac18-80a137658811.png)

**P.S.** The weather on this screenshot is not good, becouse before i tested pipelines. 

**Step4**. Create Jenkinsfile for every branch. 

Let's see to pipeline for **main** branch. Code you can find by the link: https://github.com/AndrukhivAndriy/for_jenkins/blob/main/Jenkinsfile

On the stage (Test code) we try to find word "MAIN" in file index.html. Test is FAILED when there are no word "MAIN" in index.html

On the stage (Deploy code) we just copy index.html to Nginx root. 

On the stage (Notification on Telegram) we just send information to telegram bot. 

The pipeline for branch **dev** is similar, so will not describe it. The reaseon - on stage (Test code) we are looking for word "DEVELOP", not "MAIN". 

You can find pipeline for branch **dev** by the link: https://github.com/AndrukhivAndriy/for_jenkins/blob/dev/Jenkinsfile

**Step5**

Build project for every branch manualy and look to the Consule output:

<table>
    <tr> 
        <th></th>
        <th></th>
    </tr>
    </table>
