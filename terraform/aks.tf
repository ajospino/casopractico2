resource "azurerm_kubernetes_cluster" "aks-cluster"{
  name                = format("%s-%s",local.resource_group_name,"aks")
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-service"
  sku_tier            = "Free"
  
  default_node_pool {
    name       = format("%s%s",local.resource_group_name,"nodepool")
    node_count = 2
    vm_size    = "Standard_E2_v3"
  }

  identity {
    type = "SystemAssigned"
  }
}