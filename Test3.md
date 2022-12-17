# TASK 3

**Task:** Deploy LMS Moodle in AWS

**Common description. Recommended solution:**

Users LMS Moodle goto Load Balancer which connect to Instances, which are located in private subnets AZ A and AZ B.
We have 6 subnets (2 private for DB, 2 private for Instances, 2 public for Bastion Host)
We have Auto Scaling Group   (min=1, max=4). As DB - we use Aurora with replica. For DB queries caching we use ElastiCache. 
All Moodle data collected on S3 with a distributed file system(EFS). Also we need organize backups (is enabled by default in EFS)
and logs storage, monitoring. Monthly budget about 140 $.  

<img src="https://user-images.githubusercontent.com/79985930/208230552-9d3cce26-9094-44cf-81f6-907c872a76bf.png" width="700" height="400">

VPS: 10.0.0./16
Subnet (private) for instances AZ - A: 10.0.11.0/24
Subnet (private) for instances AZ - B: 10.0.12.0/24
Subnet(private) for DB AZ - A: 10.0.21.0/24
Subnet(private) for DB AZ - B: 10.0.22.0/24
Subnet (public) for Bastion Host - 10.0.31.0/24 with NAT

**Steps:**

1. Create Db Aurora based on Mysql with replica in DB subnets;
2. Create EFS - for Moodle data;
3. Create ElastiCache - cache DB queries;
4. Register hostname in Route 53;
5. Create Instances in private subnets;
6. Create BastionHost in public subnet;
7. Mount EFS to Instances;
8. Download, install and configure Moodle;
9. Create Load Balancer for instances;
10. Create Auto Scaling Group.

## Description of infrastructure which was realized. 

Оскільки безкоштовні ресурси закінчились, була реалізована така схема (з метою економії власних коштів та часу через постійні позапланові відключення електроенергії).
All resources where created in default VPC. 

<img src="https://user-images.githubusercontent.com/79985930/208230585-e45488a3-f2fc-42bc-a93a-08b902ce77a1.png" width="700" height="400">

**1 STEP. Create database.** 

- RDS Available versions : Aurora (Mysql 5.7) 2.10.2 
- DB cluster identifier : Moodle
- DB instance class : t2 small
- Multi-AZ deployment: Don't create an Aurora replica

<img src="https://user-images.githubusercontent.com/79985930/208230711-0ecb9547-1c13-4704-b956-a031d4c9b5b8.png" width="600" height="100">

**2 STEP. Create EFS.** 

Create a SecGroup with open ports 80, 22, 2049. 

Via terminal let’s enter to instance and run commands:

    # cd /var
    # mkdir moodledata
    # vi /etc/fstab  --- add line “fs-0183f57c8878205cd:/ /var/moodledata efs _netdev,noresvport,tls”   ----- to auto mount EFS to Instance

<img src="https://user-images.githubusercontent.com/79985930/208230835-65b5f7fa-ecce-4990-88dc-f57c1b117494.png" width="700" height="200">

**3 STEP. Install extras**

    # yum install amazon-linux-extras
    # amazon-linux-extras enable php7.4
    # yum clean metadata
    # yum install php-cli php-pdo php-fpm php-json php-mysqlnd
    # systemctl start httpd
    # systemctl enable httpd.service

**4 STEP. Install Moodle dependencies**

    # yum install git
    # yum install php-gd
    # yum install php-pear
    # yum install php-mbstring
    # yum install memcached
    # yum install php-mcrypt
    # yum install php-xmlrpc
    # yum install php-soap
    # yum install php-intl
    # yum install php-zip
    # yum install php-zts
    # yum install php-xml

**5 STEP. Download Moodle**

    # wget https://download.moodle.org/download.php/stable311/moodle-3.11.11.zip
    
The last version is 4. But we will install v3. Unzip it and copy to /var/www/html

**6 STEP. Install Moodle**

Via browser let’s install Moodle. Paste next variables in text fields:

-	Moodle directory: /var/moodledata  //Mounted directory via EFS//;
-	DB host : moodledb.cluster-cuflxiniz7eh.eu-central-1.rds.amazonaws.com // DNS taken from RDS //;
-	Other fields are default.

**7 STEP. Create AMI**

Create Image snapshot from Instance with name – MoodleInstanceImageGL and launch second instance from this image with the same parameters. AMI we will use next when we will create Auto Scaling Group. 

<img src="https://user-images.githubusercontent.com/79985930/208230980-ec1b5fa8-f3dd-491a-a55c-e1afe4a202cb.png" width="600" height="100">

**8 STEP. Create Load Balancer (Application Load Balancer)**

Create Target Group with two created instances. Touch this Target Group to Load Balancer. 

<img src="https://user-images.githubusercontent.com/79985930/208231036-3818eedb-160f-4f68-8432-62120ce132be.png" width="600" height="200">


**9 STEP. Create Auto Scaling Group**

-	Create Launch Template: Content from AMI - MoodleInstanceImageGL, Instance : t2.micro;
-	Create Auto Scaling Group: Attach to existing load balancer
-	Desired capasity =1
-	Min cap = 1
-	Max cap = 2

P.S. To test you can use the follow link http://moodleloadbalancer-1594051106.eu-central-1.elb.amazonaws.com/ . By default it will redirect to IP of first instance because it’s in Moodle config file as default hostname. To solve this problem you have to use domain name (you must register it, for example in Route 53) and change main config Moodle file. Then everything will work properly.

P.S.v2. I will delete all created infrastructure on Monday 19.12 morning.    




