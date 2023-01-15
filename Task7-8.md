**Task:** https://docs.google.com/presentation/d/1dWpGENLxnHXEjVzua42dJnQ-B1dsiRdzCTLU_9OJNn4/edit#slide=id.p6

There are two ways to solve this task. At the end - we will have the same resoult. Playbooks where tested on AWS AMI Ubuntu 22.04 The playbooks will add to /etc/pam.d/common-password line like this:

    password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=8 difok=3 reject_username
    
In both cases we will use **pam_cracklib** package, not **pam_pwquality.so**, because it's the newest package. 

## Way#1. Using pamd module

The playbook is available by the link: https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/main/ansible/pinga.yml
The playbook will add line

    password   required pam_cracklib.so try_first_pass retry=3 minlen=8 reject_username

to */etc/pam.d/common-password* after line *password   [success=1 default=ignore] pam_unix.so obscure yescrypt*

## Way#2(optional). Insert password rule directly.

The playbook is available by the link: https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/main/ansible/main2.yml

**Common explanation for playbooks:**

The playbook starts by installing the pam_cracklib package, which is used to enforce password complexity rules. Next, the playbook updates the /etc/pam.d/common-password file to include the following settings:

        try_first_pass: this tells pam_cracklib to use the password entered by the user as the first password to check.
        retry=3: this tells pam_cracklib to give the user 3 chances to enter a valid password before failing.
        minlen=8: this tells pam_cracklib to require a minimum password length of 8 characters.
        reject_username: this tells pam_cracklib to reject passwords that contain the username.
        
## Resoults


