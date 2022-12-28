## Task : [Task 6](https://docs.google.com/document/d/1hxknpDiPfIDCFRAFUaZQVtm8BbpQpaX1gbPzxWuM-Y8/edit)

As my grandma likes AWS more than Azure - it was realized next schema:

Module AWS: 

- Auto Scaling Group;
- Load Balancer (that is why the export is domain name, not IP)

Module Azure:

- Simple VM with installed Grafana;
- port redirect via shell script (3000 -> 80)

### To run script:

- download it or git clone;
- set ssh_key for instances in folder /userdata;
- set credentials for AWS and Azure;
- set your variables;
- install on your local machine Terraform - [https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

run in shell:

- **terraform init**
- **terraform plan**
- **terraform apply**

## The resoults: 

As the resoult of script we output 2 variables:
