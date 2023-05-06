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

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.cloud.name
  virtual_network_name = azurerm_virtual_network.cloud.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_interface" "internal" {
  name                = "dev-int-nic"
  location            = azurerm_resource_group.cloud.location
  resource_group_name = azurerm_resource_group.cloud.name
  dns_servers         = ["8.8.8.8", "1.1.1.1"]

  ip_configuration {
    name                          = "dev-int-nic-config"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "kubeedge_master" {
  name                = "kubeedge-master"
  location            = azurerm_resource_group.cloud.location
  resource_group_name = azurerm_resource_group.cloud.name
  allocation_method   = "Static"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "external" {
  name                = "dev-ext-nic"
  location            = azurerm_resource_group.cloud.location
  resource_group_name = azurerm_resource_group.cloud.name
  dns_servers         = ["8.8.8.8", "1.1.1.1"]

  ip_configuration {
    name                          = "dev-ext-nic-config"
    subnet_id                     = azurerm_subnet.external.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.kubeedge_master.id
  }
}
