resource "azurerm_dns_zone" "domain-dns" {
  name                = local.personal_domain
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_dns_a_record" "app-record" {
  name                = "www"
  zone_name           = azurerm_dns_zone.domain-dns.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [ azurerm_public_ip.app-public-ip.ip_address ]
}