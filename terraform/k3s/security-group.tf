resource "azurerm_network_security_group" "k3s" {
  name                = "k3s"
  location            = azurerm_resource_group.cloud.location
  resource_group_name = azurerm_resource_group.cloud.name

  security_rule {
    name                       = "k3s"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["2379", "2380", "6443", "8472", "10250", "51820", "51821", "51871"]
    source_address_prefixes    = ["10.0", "10.112", "103.82.14.237", azurerm_public_ip.nat.ip_address]
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "k3s-master" {
  network_interface_id      = azurerm_network_interface.external.id
  network_security_group_id = azurerm_network_security_group.k3s.id
}

resource "azurerm_network_interface_security_group_association" "k3s-worker" {
  network_interface_id      = azurerm_network_interface.internal.id
  network_security_group_id = azurerm_network_security_group.k3s.id
}
