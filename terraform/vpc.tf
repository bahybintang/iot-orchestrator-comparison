resource "azurerm_virtual_network" "cloud" {
  name                = "cloud-network"
  location            = azurerm_resource_group.cloud.location
  resource_group_name = azurerm_resource_group.cloud.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    env = "dev"
  }
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.cloud.name
  virtual_network_name = azurerm_virtual_network.cloud.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "external" {
  name                 = "external"
  resource_group_name  = azurerm_resource_group.cloud.name
  virtual_network_name = azurerm_virtual_network.cloud.name
  address_prefixes     = ["10.0.2.0/24"]
}
