resource "azurerm_network_security_group" "nsg" {
  name                = format("%s-%s",local.resource_group_name,"nsg")
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = local.personal_ip_address
    destination_address_prefixes = ["10.0.0.10","10.0.0.14"]
}

  security_rule {
    name                       = "MySQL"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = local.personal_ip_address
    destination_address_prefix = "10.0.0.14"
  }

    security_rule {
    name                       = "REDIS"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "6379"
    source_address_prefix      = local.personal_ip_address
    destination_address_prefix = "10.0.0.14"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-sn" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}