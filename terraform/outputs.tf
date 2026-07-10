output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "app-vm_id" {
  value = azurerm_linux_virtual_machine.app-vm.id
}

output "service-vm_id" {
  value = azurerm_linux_virtual_machine.service-vm.id
}

output "general-acr_login-server" {
  value = azurerm_container_registry.general-acr.login_server
}

resource "local_file" "inventory-output" {
  content = templatefile("${path.module}/inventory.tpl",
    {
      app-vm-public-ip = azurerm_public_ip.app-public-ip.ip_address
      service-vm-public-ip = azurerm_public_ip.service-public-ip.ip_address
    }
  )
  filename = "../ansible/inventory"
}

resource "local_file" "acr-output" {
  content = templatefile("${path.module}/acr-output.tpl",
    {
      acr_login_url = azurerm_container_registry.general-acr.login_server
      acr_user = azurerm_container_registry.general-acr.admin_username
      acr_password = azurerm_container_registry.general-acr.admin_password
    }
  )
  filename = "../ansible/.env.acr-output"
}