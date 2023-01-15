# Task:
https://docs.google.com/presentation/d/1dWpGENLxnHXEjVzua42dJnQ-B1dsiRdzCTLU_9OJNn4/edit#slide=id.p6

There are two ways to solve this task. At the end - we will have the same resoult. Playbooks where tested on AWS AMI Ubuntu 22.04 The playbooks will add to /etc/pam.d/common-password line like this:

    password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=8 difok=3 reject_username
    
## Way#1. Using pamd module

The playbook is available by the link: 

The playbook will add line

    password   required pam_cracklib.so try_first_pass retry=3 minlen=8 reject_username

to */etc/pam.d/common-password* after line *password   [success=1 default=ignore] pam_unix.so obscure yescrypt*
