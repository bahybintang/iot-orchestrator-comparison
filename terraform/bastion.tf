resource "azurerm_public_ip" "bastion" {
  name                = "bastion"
  location            = azurerm_resource_group.cloud.location
  resource_group_name = azurerm_resource_group.cloud.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion"
  location            = azurerm_resource_group.cloud.location
  resource_group_name = azurerm_resource_group.cloud.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}
