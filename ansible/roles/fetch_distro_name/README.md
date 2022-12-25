## fetch a linux distro name/version

In this role we installed Apache server and genereted index.html file wich show us on web page different kinds of variables. 
The variables are shown via terminal by using :

  - debug: var=ipify_public_ip
  - debug: var=ansible_hostname
  - debug: var=ansible_os_family
  
And the second way - go to IP of instance from inventory via browser. You will see values of each mashines:

		Host family of instance : {{ ansible_os_family  }} # variable taken from system
		Distribution :  {{ ansible_distribution }} # variable taken from system
		Distribution major version is :  {{ ansible_distribution_major_version }} # variable taken from system
		The owner :   {{ owner }} # variable taken from inventory file
		Internal IP of this instance :  {{ ansible_default_ipv4.address }} # variable taken from system

**Index.html was created via Jinja Template.** 

Also was realized notify + handler. When we make some changes to index.j2 - ansible will restart Apache. 