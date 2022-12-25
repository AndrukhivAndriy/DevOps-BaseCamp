## Task: use ansible_user and ansible_password for ssh connection and store passwords for each VM in encrypred way

1. We create a user ansible_user on each machine. User belongs to group Wheel
2. To allow password auth via ssh - have to change /etc/ssh/sshd.config and change parametr "PasswordAuthentication" form "no" to "yes"
3. To ecrypt user's password we use Ad-Hoc - \# ansible-vault encrypt_string --vault-password-file pass --name ansible_password, where pass -- is file with user password
4. To run playbook : ansible-playbook playbook3.yml --vault-password-file ./pass 
5. The content of file ./pass : hello