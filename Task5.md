## Task

- Create a inventory file with four groups, each provisioning VM should be in separate group and group named iaas what should include childrens from two first groups;
- Create reusable roles for that:
    - creating a empty file /etc/iaac with rigths 0500
    - fetch a linux distro name/version

- Create playbook for:

    invoke the role for /etc/iaac for hosts group iaas
    invoke the role for defining variable for all hosts
    print in registered variables
    printing hostnames together with registered variables will be a plus.
    Create a repo in your GitHub account and commit code above

Let's do this task step by step. At the end of this topic you will find link to full Ansible code.

Inventory:

[staging_servers_web]
aws_ns1 ansible_host=x.x.x.x

[staging_servers_web:vars]  /////// CREATE dir /group_vars , cretae file staging_servers_web and add strings in yml
ansible_user=ec2-user
ansible_ssh_private_key_file=/home/.....

[prod_servers_web]
aws_ins2 ansible_host=x.x.x.x


[ALL_servers:children]
staging_servers_web
prod_servers_web

Ad-Hoc

1. ansible all -m copy -a "src=pr.txt dest=/home mode=755" -b
2. ansible all -m shell -a "ls -la /home"

Print var:

- name: My playbook
  hosts: all
  become:yes
  
  vars:
    message1: Text1
    message2: Text2
    
  tasks:
  
  - name: Print Message
    debug:
      msg: "Your message is {{ message1 }}"
      var: message1

INFO anbout servers:

ansible all -m setup

- debug:
    var: ansible_distribution
