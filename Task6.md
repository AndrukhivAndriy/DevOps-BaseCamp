## Task : [Task 6](https://docs.google.com/document/d/1hxknpDiPfIDCFRAFUaZQVtm8BbpQpaX1gbPzxWuM-Y8/edit)

As my grandma likes AWS more than Azure - it was realized next schema:

Module AWS: -- [https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/Terraform_main/modules/aws](https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/Terraform_main/modules/aws)

- Auto Scaling Group;
- Load Balancer (that is why the export is domain name, not IP)

Module Azure: -- [https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/Terraform_main/modules/azure](https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/Terraform_main/modules/azure)

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

![Screenshot_1](https://user-images.githubusercontent.com/79985930/209865748-176d306e-1a70-4282-8667-7af9d0941be1.png)

And the screenshots from browser are there:

<table>
  <tr>
    <th><img src="https://user-images.githubusercontent.com/79985930/209865749-e04f7045-d392-4e67-ae68-f80313361725.png"></th>
    <th><img src="https://user-images.githubusercontent.com/79985930/209865751-523239ed-5375-4a59-8f1b-93728fa2e808.png"></th>
  </tr>
</table>

So, the links:


Hello Grafana from AWS : <a href="http://Grafana-elb-292409992.eu-central-1.elb.amazonaws.com" target="_blank">Grafana-elb-292409992.eu-central-1.elb.amazonaws.com</a>
    
Hello Grafana from Azure : <a href="http://20.101.100.25/" target="_blank">20.101.100.25</a>

And the hole script, by the link: [https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/Terraform_main](https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/Terraform_main)


