########################################################################################
# Data de criação: 22 de Novembro de 2021                                              #
#                                                                                      #
# Autoria: Márcio Tadeu                                                                #
# Contato: marcio.ts6@terra.com.br                                                     #
#                                                                                      #
# Nome do script: Vagrantfile                                                          #
# Version: 1.1                                                                         #
# Data: 22/12/2021                                                                     #
#                                                                                      #
# Descrição: This script is a usefull example for provisioning lab environments with   #
# virtualbox                                                                           #
# Projeto: Environment                                                                 #
#                                                                                      #
# Repositório de publicação: https://github.com/marcio-tadeu/usefullscripts            #
#                                                                                      #
# Uso: Vagrant up              			                                       			           #
# Parâmetros: n/a                                          			               			       #
# Legenda parâmetros: n/a                                                   		         #
#                                                                                      #
# This script was validate executing on linux mint version="20.2"                      #
#                                                                                      #
########################################################################################
 
#---------------------------------- GLOBAl ENTRIES —-----------------------------------#                
#--------------------------------------------------------------------------------------#
                 
#-------------------------------------------- TESTS -----------------------------------#
#--------------------------------------------------------------------------------------#
                 
#----------------------------------------- FUNTIONS -----------------------------------#
#--------------------------------------------------------------------------------------#

#--------------------------------------- EXECUTIONS -----------------------------------#
#--------------------------------------------------------------------------------------#
 
#------------------------------------ COMMENTS ----------------------------------------#
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
