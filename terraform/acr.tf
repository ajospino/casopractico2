resource "azurerm_container_registry" "general-acr" {
  name                = format("%s%s",local.resource_group_name,"registry")
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}