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
