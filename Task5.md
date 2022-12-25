## Task. By the link [https://github.com/yurnov/IaC_Ansible_basecamp/blob/9ed49abab70f135495bf9738b2657c12076ab39a/08-homework.md](https://github.com/yurnov/IaC_Ansible_basecamp/blob/9ed49abab70f135495bf9738b2657c12076ab39a/08-homework.md)

1. Create 4 linux machines in AWS


    VAULT:
    
    1. ansible-playbook playbook3.yml --vault-password-file ./pass   ---- to run playbook
    2. ansible-vault encrypt_string --vault-password-file pass --name ansible_password
