resource "azurerm_network_interface" "internal" {
  name                = "${var.orchestrator_name}-int-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_servers         = ["8.8.8.8", "1.1.1.1"]

  ip_configuration {
    name                          = "${var.orchestrator_name}-int-nic-config"
    subnet_id                     = var.internal_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    orchestrator = var.orchestrator_name
  }
}

resource "azurerm_public_ip" "master" {
  name                = "${var.orchestrator_name}-master"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Basic"

  tags = {
    orchestrator = var.orchestrator_name
  }
}

resource "azurerm_network_interface" "external" {
  name                = "${var.orchestrator_name}-ext-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_servers         = ["8.8.8.8", "1.1.1.1"]

  ip_configuration {
    name                          = "${var.orchestrator_name}-ext-nic-config"
    subnet_id                     = var.external_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.master.id
  }

  tags = {
    orchestrator = var.orchestrator_name
  }
}
