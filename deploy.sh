#!/bin/bash
cd terraform/
terraform init 
terraform plan -out cp2.tfplan
terraform apply --auto-approve cp2.tfplan
az aks get-credentials --resource-group $(terraform output -raw resource_group_name) --name $(terraform output -raw kubernetes_cluster_name)

cd ../ansible
ansible-playbook playbook-create-image.yml
ansible-playbook playbook-app.yml
ansible-playbook playbook-aks.yml
