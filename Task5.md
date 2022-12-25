## Task. 

By the link [https://github.com/yurnov/IaC_Ansible_basecamp/blob/9ed49abab70f135495bf9738b2657c12076ab39a/08-homework.md](https://github.com/yurnov/IaC_Ansible_basecamp/blob/9ed49abab70f135495bf9738b2657c12076ab39a/08-homework.md)

## Solution

1. **Create 4 linux machines in AWS**
<img src="https://user-images.githubusercontent.com/79985930/209460676-42b5b6cb-293c-4f9c-b4cf-1afe53354d89.png">

2. **Create a inventory** file with four groups, each provisioning VM should be in separate group and group named iaas what should include childrens from two first groups.

Is available by the link (in INI format): [https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/18a64d678d1a19f233e223ea34098f2055197f0b/ansible/hosts.ini](https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/18a64d678d1a19f233e223ea34098f2055197f0b/ansible/hosts.ini)

3. **Create Role: creating a empty file /etc/iaac with rigths 0500**

Is available by the link: [https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/ansible/roles/create_empty_file](https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/ansible/roles/create_empty_file)

4. **Create Role: fetch a linux distro name/version.**

In this case we will print all data on web page via using Jinja Template. So, the resoults are shown on next pictures.

<table>
  <tr>
    <th><img src="https://user-images.githubusercontent.com/79985930/209460678-5c6c9821-1cec-4f69-80a7-35b8fe0f68fd.png"></th>
    <th><img src="https://user-images.githubusercontent.com/79985930/209460677-a9b78109-7d4c-452c-abd8-d819049ea893.png"></th>
    <th><img src="https://user-images.githubusercontent.com/79985930/209460673-90d2ecdb-490d-4647-ae88-52953a1798a7.png"></th>
  </tr>
</table>

The Role is available by the link: [https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/ansible/roles/fetch_distro_name](https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/ansible/roles/fetch_distro_name)

**Optional: use ansible_user and ansible_password for ssh connection and store passwords via Vault**
   
1. Encrypt user password. The password is in file ./pass. We will use Ad-Hoc:

ansible-vault encrypt_string --vault-password-file pass --name ansible_password

The Playbook wich realise taks is available by the link: [https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/18a64d678d1a19f233e223ea34098f2055197f0b/ansible/playbook3.yml](https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/18a64d678d1a19f233e223ea34098f2055197f0b/ansible/playbook3.yml)

The password is "hello" and file with password is available by the link: [https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/18a64d678d1a19f233e223ea34098f2055197f0b/ansible/pass](https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/18a64d678d1a19f233e223ea34098f2055197f0b/ansible/pass)

To run Playbook use : **ansible-playbook playbook3.yml --vault-password-file ./pass**
  
**P.S.**

THE HOLE SCRIPTS ARE - [https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/ansible](https://github.com/AndrukhivAndriy/DevOps-BaseCamp/tree/main/ansible)
