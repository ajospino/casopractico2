output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "app-vm_id" {
  value = azurerm_linux_virtual_machine.app-vm.id
}

output "service-vm_id" {
  value = azurerm_linux_virtual_machine.service-vm.id
}