output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "app-vm_id" {
  value = azurerm_linux_virtual_machine.app-vm.id
}

output "service-vm_id" {
  value = azurerm_linux_virtual_machine.service-vm.id
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
