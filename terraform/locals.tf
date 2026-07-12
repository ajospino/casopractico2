locals {
  envs = { for tuple in regexall("(.*?)=(.*)", file(".env")) : tuple[0] => tuple[1] }
  app_vm_name         = format("%s-%s",local.envs["RESOURCE_GROUP_NAME"],local.envs["APP_VM_NAME"])
  subnet_name         = format("%s-%s",local.envs["RESOURCE_GROUP_NAME"],local.envs["SUBNET_NAME"])
  network_name        = format("%s-%s",local.envs["RESOURCE_GROUP_NAME"],local.envs["NETWORK_NAME"])
  location_name       = local.envs["LOCATION_NAME"]
  resource_group_name = local.envs["RESOURCE_GROUP_NAME"]
  subscription_id     = local.envs["SUBSCRIPTION_ID"]
  personal_ip_address = local.envs["PERSONAL_IP_ADDRESS"]
  personal_domain     = local.envs["PERSONAL_DOMAIN"]
}