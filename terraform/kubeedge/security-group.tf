resource "azurerm_network_security_group" "kubeedge" {
  name                = "kubeedge"
  location            = azurerm_resource_group.cloud.location
  resource_group_name = azurerm_resource_group.cloud.name

  security_rule {
    name                       = "kubeedge"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["2379", "2380", "6443", "8472", "10250", "51820", "51821"]
    source_address_prefixes    = ["10.0"]
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "kubeedge-master" {
  network_interface_id      = azurerm_network_interface.external.id
  network_security_group_id = azurerm_network_security_group.kubeedge.id
}

resource "azurerm_network_interface_security_group_association" "kubeedge-worker" {
  network_interface_id      = azurerm_network_interface.internal.id
  network_security_group_id = azurerm_network_security_group.kubeedge.id
}
