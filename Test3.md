# TASK 3

**Завдання.** Розгорнути LMS Moodle у AWS

**Common description. Recommended solution:**

Users LMS Moodle goto Load Balancer which connect to Instances, which are located in private subnets AZ A and AZ B.
We have 6 subnets (2 private for DB, 2 private for Instances, 2 public for Bastion Host)
We have Auto Scaling Group   (min=1, max=4). As DB - we use Aurora with replica. For DB queries caching we use ElastiCache. 
All Moodle data collected on S3 with a distributed file system(EFS). Also we need organize backups (is enabled by default in EFS)
and logs storage, monitoring. Monthly budget about 140 $.  

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
6. Mount EFS to Instances;
7. Download, install and configure Moodle;
8. Create Load Balancer for instances;
9. Create Auto Scaling Group.

## Description of infrastructure which was realized. 

Оскільки безкоштовні ресурси закінчились, була реалізована така схема (з метою економії власних коштів).

