# 1. Comentar dependecias 
resource "azurerm_resource_group" "simple_rg" {
  name = "terraform-pks-dev"
  location = "west europe"
  tags = {
    environment = "dev"
    created_by  = "terraform"
  }
}

resource "azurerm_virtual_network" "simple_vnet" {
  name                = "terraform-pks-dev"
  address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.simple_rg.location
    resource_group_name = azurerm_resource_group.simple_rg.name
    tags = azurerm_resource_group.simple_rg.tags
}

resource "azurerm_subnet" "subnets" {
  count               = 3
  name                = "subnet-${count.index + 1}"
  resource_group_name = azurerm_resource_group.simple_rg.name
  virtual_network_name = azurerm_virtual_network.simple_vnet.name
  address_prefixes    = ["10.0.${count.index}.0/24"]
}

output "subnet_ids" {
  value = azurerm_subnet.subnets[*].id
  description = "Subnet ids"
}

output "subnet_ranges" {
  value = {for subnet in azurerm_subnet.subnets : subnet.name => subnet.address_prefixes[0]}
  description = "Subnet name and address prefix"
}