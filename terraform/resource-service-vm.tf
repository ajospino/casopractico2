resource "azurerm_network_interface" "service-nic" {
  name                = format("%s/%s",local.resource_group_name,"service-vm-nic")
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.4"
    public_ip_address_id          = azurerm_public_ip.service-public-ip.id
  }
}

resource "azurerm_public_ip" "service-public-ip" {
  name                = "cp2-service-vm-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}

resource "azurerm_linux_virtual_machine" "service-vm" {
  name                = format("%s/%s","service-",local.vm_name)
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_E2s_v3"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.service-nic.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(".ssh/az-public-key.pem")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}