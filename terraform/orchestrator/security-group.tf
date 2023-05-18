resource "azurerm_network_security_group" "main" {
  name                = "${var.orchestrator_name}-sg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "${var.orchestrator_name}-sg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = var.allowed_ports
    source_address_prefixes    = var.allowed_source_addresses
    destination_address_prefix = "*"
  }

  tags = {
    orchestrator = var.orchestrator_name
  }
}

resource "azurerm_network_interface_security_group_association" "master" {
  network_interface_id      = azurerm_network_interface.external.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_network_interface_security_group_association" "worker" {
  network_interface_id      = azurerm_network_interface.internal.id
  network_security_group_id = azurerm_network_security_group.main.id
}
