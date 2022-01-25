#!/usr/bin/env bash expect -f

GRAFPASS=
PUBIPHOTMART=""
SERVERS="/home/marcio/Documentos/estudar/ti/terraform/hotmart_v3/inventory"

for HOST in ${SERVERS[@]}; do 
    ####### Adding the new virtual machine name on the /etc/hosts #######
    ssh marcio@${HOST} -t 'sudo sed -i "\$a "$PUBIPHOTMART" hotmartvm" /etc/hosts'
    
    ####### Working with the generate and copying ssh keys for ansible automation #######
    ssh marcio@${HOST} -t 'sudo bash -c echo -e "\n\n\n" | ssh-keygen -t rsa -f /home/marcio/.ssh/id_rsa -q -P ""'
    ssh marcio@${HOST} -t 'sudo echo "yes \n" | sudo ssh-copy-id -i /home/marcio/.ssh/id_dsa.pub marcio@localhost:/tmp'
    ssh marcio@${HOST} -t 'sudo sed -i "\$a LoginGraceTime 120" /etc/ssh/sshd_config'
    ssh marcio@${HOST} -t 'sudo sed -i "\$a PermitRootLogin yes" /etc/ssh/sshd_config'
   #ssh marcio@${HOST} -t 'sudo sed -i "\$a PasswordAuthentication no" /etc/ssh/sshd_config'
    ssh marcio@${HOST} -t 'sudo sed -i "\$a PubkeyAuthentication yes" /etc/ssh/sshd_config'
    ssh marcio@${HOST} -t 'sudo sed -i "\$a ChallengeResponseAuthentication no" /etc/ssh/sshd_config'

    if [[ $? -ne 0 ]]; then
        echo "ERROR: $HOST did not complete"
     else   
        echo "$HOST complete"
    fi
done