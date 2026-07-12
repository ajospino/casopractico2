resource "local_file" "inventory-output" {
  content = templatefile("${path.module}/inventory.tpl",
    {
      app-vm-public-ip = azurerm_public_ip.app-public-ip.ip_address
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
  filename = "../ansible/acr-output.yml"
}