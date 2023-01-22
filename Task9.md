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

To install Jenkins manualy follow this link: https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/

OR you can create a simple bash script and paste this script to block *User data*

## Solving task with Multibranches

**Step1**. Create a GitHub repo with 2 branches - **main** and **dev**. With 2 files: 

- **index.html** - will deploy on web server
- **Jenkinsfile** - pipeline for every branch

Repo is accesible by the link - https://github.com/AndrukhivAndriy/for_jenkins

**Step2**. Create Credentials to access GitHub. 

Via *ssh-keygen* just create pub and private keys and put them into GitHub and Jenkins.

![Screenshot_17](https://user-images.githubusercontent.com/79985930/213903320-b0f64b86-789b-4930-84aa-78b24b60299f.png)

**Step3**. Then you will find (after clicking on Status) our 2 branches from GitHub:

![Screenshot_18](https://user-images.githubusercontent.com/79985930/213903470-c10549fc-450d-45bd-ac18-80a137658811.png)

**P.S.** The weather on this screenshot is not good, becouse before i tested pipelines. 

**Step4**. Create Jenkinsfile for every branch. 

Let's go to Jenkinsfile in **main** branch. Code you can find by the link: https://github.com/AndrukhivAndriy/for_jenkins/blob/main/Jenkinsfile

On the stage (Test code) we try to find word "MAIN" in file index.html. Test is FAILED when there are no word "MAIN" in index.html

On the stage (Deploy code) we just copy index.html to Nginx root. 

On the stage (Notification on Telegram) we just send information to telegram bot. 

The pipeline for branch **dev** is similar, so will not describe it. The reaseon - on stage (Test code) we are looking for word "DEVELOP", not "MAIN". 

You can find pipeline for branch **dev** by the link: https://github.com/AndrukhivAndriy/for_jenkins/blob/dev/Jenkinsfile

**Step5**

Build project for every branch manualy and look to the Consule output:

<table>
    <tr>
    <th> MAIN BRANCH
        </th>
        <th>
            DEV BRANCH
        </th>
    </tr>
    <tr> 
        <td> <img src="https://user-images.githubusercontent.com/79985930/213904349-81b48ef6-3d05-44a0-b56a-d2727d81cacd.png"> </td>
        <td> <img src="https://user-images.githubusercontent.com/79985930/213904403-e5209520-a665-4e45-b7cc-0fa959639d4c.png"> </td>
    </tr>
    </table>

**In pipelines we are using 2 system variables:**

        BUILD_ID -- number of build 
        JENKINS_URL - where Jenkins is working
        
**RESOULTS**

As we deploy index.html to Nginx - let's see on those web pages:

<table>
    <tr>
    <th> MAIN BRANCH
        </th>
        <th>
            DEV BRANCH
        </th>
    </tr>
    <tr> 
        <td> <img src="https://user-images.githubusercontent.com/79985930/213904885-b091d2a4-2a10-41df-a254-dda59cbabca9.png"> </td>
        <td> <img src="https://user-images.githubusercontent.com/79985930/213904886-8b5101f5-e1ad-4373-b145-0cb2462eddc7.png"> </td>
    </tr>
    </table>
    
And notifications on my Telegram (created Jenkinsbot):

![Screenshot_23](https://user-images.githubusercontent.com/79985930/213904979-0f69c8c7-5324-4a55-bf70-f2ff5d1f4661.png)

## Integration Jenkins with GitHub via WebHook

If you wish to automate the build process in the multibranch pipeline we can use Webhook. This feature is not enabled until we install “Multibranch Scan Webhook Trigger”. This enables an option “scan by webhook” under “Scan Multibranch Pipeline Triggers”. Here we should give a token. I am giving it as “mytoken”. by this time job looks something like below.

**STEP1**. 

Install plugin *multibranch-scan-webhook-trigger*

**STEP2**

Add trigger: Scan Repository Triggers in Menu

![Screenshot_25](https://user-images.githubusercontent.com/79985930/213906347-28810570-ca37-4e31-a50b-05dc8973df1f.png)

Add WebHook to GitHub

![Screenshot_26](https://user-images.githubusercontent.com/79985930/213906429-7fe719ff-0f31-46d6-81cd-cc01ff220109.png)

