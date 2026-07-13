#!/bin/bash
cd terraform/
tofu init 
tofu plan -out cp2.tfplan
tofu apply --auto-approve cp2.tfplan
az aks get-credentials --resource-group $(tofu output -raw resource_group_name) --name $(tofu output -raw kubernetes_cluster_name)

cd ../ansible
ansible-playbook playbook-create-image.yml
ansible-playbook playbook-app.yml
ansible-playbook playbook-aks.yml
