# TASK 3

**Завдання.** Розгорнути LMS Moodle у AWS

**Common description. Recommended solution:**

Users LMS Moodle goto Load Balancer which connect to Instances, which are located in private subnets AZ A and AZ B.
We have Auto Scaling Group   (min=1, max=4). As DB - we use Aurora with replica. For DB queries caching we use ElastiCache. 
All Moodle data collected on S3 with a distributed file system(EFS). Also we need organize backups (is enabled by default in EFS)
and logs storage, monitoring. Monthly budget about 140 $.  
