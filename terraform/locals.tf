locals {
  envs = { for tuple in regexall("(.*?)=(.*)", file(".env")) : tuple[0] => sensitive(tuple[1]) }
  vm_name = format("%s/%s",local.envs["RESOURCE_GROUP_NAME"],local.envs["VM_NAME"])
  subnet_name = format("%s/%s",local.envs["RESOURCE_GROUP_NAME"],local.envs["SUBNET_NAME"])
  network_name = format("%s/%s",local.envs["RESOURCE_GROUP_NAME"],local.envs["NETWORK_NAME"])
  location_name = format("%s/%s",local.envs["RESOURCE_GROUP_NAME"],local.envs["LOCATION_NAME"])
  resource_group_name = local.envs["RESOURCE_GROUP_NAME"]
}