#!/bin/bash
cd terraform/
tofu init 
tofu plan -out cp2.tfplan
tofu apply --auto-approve cp2.tfplan

cd ../ansible
ansible-playbook playbook-create-image.yml
ansible-playbook -i inventory -u azureuser --private-key ../.ssh/az-cp2-private-key.pem playbook-app.yml
