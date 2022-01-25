########################################################################################
# Data de criação: 22 de Novembro de 2021                                              #
#                                                                                      #
# Author: Márcio Tadeu                                                                 #
# Contact: marcio.ts6@terra.com.br                                                     #
#                                                                                      #
# Script name: Vagrantfile                                                             #
# Version: 1.1                                                                         #
# Date: 22/12/2021                                                                     #
#                                                                                      #
# Description: This script is a usefull example for provisioning lab environments with #
# virtualbox                                                                           #
# Project: Environment                                                                 #
#                                                                                      #
# Publicação repository: https://github.com/marcio-tadeu/usefullscripts                #
#                                                                                      #
# Use: Vagrant up                                                                      #
# Parâmeters: n/a                                                                      #
# Parâmeters legend: n/a                                                               #
#                                                                                      #
# This script was validate executing on linux mint version="20.2"                      #
#                                                                                      #
########################################################################################
 
#---------------------------------- GLOBAl ENTRIES —-----------------------------------#                
#--------------------------------------------------------------------------------------#
                 
#------------------------------------- TESTS ------------------------------------------#
#--------------------------------------------------------------------------------------#
                 
#------------------------------------FUNTIONS -----------------------------------------#
#--------------------------------------------------------------------------------------#

#---------------------------------- EXECUTIONS ----------------------------------------#
#--------------------------------------------------------------------------------------#
 
#----------------------------------- COMMENTS -----------------------------------------#
#--------------------------------------------------------------------------------------#


Vagrant.configure("2") do |config|
  config.vm.define "rancher" do |subconfig|
    subconfig.vm.box = "bento/ubuntu-20.10"
    subconfig.vm.hostname = "rancher"   
    subconfig.vm.network :private_network, ip: "172.16.1.120"
  end

  config.vm.define "k8s-1" do |subconfig|
    subconfig.vm.box = "bento/ubuntu-20.10"
    subconfig.vm.hostname = "k8s-1"
    subconfig.vm.network :private_network, ip: "172.16.1.121"
  end

  config.vm.define "k8s-2" do |subconfig|
    subconfig.vm.box = "bento/ubuntu-20.10"
    subconfig.vm.hostname = "k8s-2"
    subconfig.vm.network :private_network, ip: "172.16.1.122"
  end

  config.vm.define "k8s-3" do |subconfig|
    subconfig.vm.box = "bento/ubuntu-20.10"
    subconfig.vm.hostname = "k8s-3"
    subconfig.vm.network :private_network, ip: "172.16.1.123"
  end

#Install avahi on all machines  
  config.vm.provision "shell", inline: <<-SHELL
    apt-get install -y apt-transport-https ca-certificates curl sshpass
  SHELL
end
