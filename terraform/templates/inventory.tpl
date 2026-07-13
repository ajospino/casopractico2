[app-vm]
${app-vm-public-ip} ansible_ssh_private_key_file=../terraform/ssh/az-cp2-private-key.pem ansible_user=azureuser

[defaults]
host_key_checking = False
