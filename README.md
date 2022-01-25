# usefullscripts



The code environment.tf script use hcl defaults language for implement infrastructure as a code with:                                                               
1- Azure Storage account                                                                                                                                             
2- AKS (Azure Kubernetes Service)                                                                                                                                   
3- 1 Azure Virtual Machine


Vagrant Environment
Vagrantfile: This script is usefull for provisioning the environment lab using the oracle virtualbox to facilitate the execution of tests and validations without having to manually configure virtual machines.


Ansible Playbooks
The graf.yml is a ansible playbook that log in a virtual machine deployed throught environment terraform script and install the grafana packages. The graf-dash.yml configure the database connections strings and home dashboards contained in inventory file.



The basic-opers scripts is reference by Sathish Arthar
https://www.techbrown.com/most-useful-bash-scripts-linux-system-administrator/
