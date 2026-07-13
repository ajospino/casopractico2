output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.aks-cluster.name
}

resource "local_file" "inventory-output" {
  content = templatefile("${path.module}/templates/inventory.tpl",
    {
      app-vm-public-ip = azurerm_public_ip.app-public-ip.ip_address
    }
  )
  filename = "../ansible/inventory"
}

resource "local_file" "acr-output" {
  content = templatefile("${path.module}/templates/acr-output.tpl",
    {
      acr_login_url = azurerm_container_registry.general-acr.login_server
      acr_user = azurerm_container_registry.general-acr.admin_username
      acr_password = azurerm_container_registry.general-acr.admin_password
    }
  )
  filename = "../ansible/variables.yml"
}

resource "local_file" "private-ssh-key" {
  content = templatefile("${path.module}/templates/priv-key.tpl",
    {
     private_ssh_key = tls_private_key.admin_ssh_key.private_key_openssh
    }
  )
  filename = "../ssh/az-cp2-private-key.pem"
}

resource "local_file" "public-ssh-key" {
  content = templatefile("${path.module}/templates/pub-key.tpl",
    {
     public_ssh_key = tls_private_key.admin_ssh_key.public_key_openssh
    }
  )
  filename = "../ssh/az-cp2-public-key.pem"
}