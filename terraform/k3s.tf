# Legacy manifest, before using orchestrator module

resource "azurerm_virtual_machine" "master" {
  name                             = "master-vm"
  location                         = azurerm_resource_group.cloud.location
  resource_group_name              = azurerm_resource_group.cloud.name
  network_interface_ids            = [azurerm_network_interface.external.id]
  vm_size                          = "Standard_DS1_v2"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  storage_os_disk {
    name              = "master-vm-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "master"
    admin_username = "k3s"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/k3s/.ssh/authorized_keys"
      key_data = azurerm_ssh_public_key.main.public_key
    }
  }

  tags = {
    env          = "dev"
    orchestrator = "k3s"
  }
}

resource "azurerm_virtual_machine" "worker" {
  name                             = "worker-vm"
  location                         = azurerm_resource_group.cloud.location
  resource_group_name              = azurerm_resource_group.cloud.name
  network_interface_ids            = [azurerm_network_interface.internal.id]
  vm_size                          = "Standard_DS1_v2"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  storage_os_disk {
    name              = "worker-vm-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "worker"
    admin_username = "k3s"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/k3s/.ssh/authorized_keys"
      key_data = azurerm_ssh_public_key.main.public_key
    }
  }

  tags = {
    env          = "dev"
    orchestrator = "k3s"
  }
}

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
    destination_port_ranges    = ["22", "2379", "2380", "6443", "8472", "10250", "51820", "51821", "51871"]
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

resource "azurerm_public_ip" "k3s_master" {
  name                = "k3s-master"
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
    public_ip_address_id          = azurerm_public_ip.k3s_master.id
  }
}
