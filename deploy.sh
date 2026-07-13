#!/bin/bash
cd terraform/
terraform init 
terraform plan -out cp2.tfplan
terraform apply --auto-approve cp2.tfplan
az aks get-credentials --overwrite-existing --resource-group  $(terraform output -raw resource_group_name) --name $(terraform output -raw kubernetes_cluster_name)

cd ../ansible
ansible-playbook playbook-create-image.yml
ansible-playbook -i inventory --private-key ../ssh/az-cp2-private-key.pem -u azureuser playbook-app.yml 
ansible-playbook playbook-aks.yml

sleep 30

aks_app_public_ip=$(kubectl get svc --namespace cp2-ns -o go-template='{{range .items}}{{ (index .status.loadBalancer.ingress 0).ip }}{{printf "\n"}}{{end}}')
echo "AKS App's public ip: $aks_app_public_ip"
