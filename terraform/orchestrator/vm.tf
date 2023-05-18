resource "azurerm_virtual_machine" "master" {
  name                             = "${var.orchestrator_name}-master-vm"
  location                         = var.resource_group_location
  resource_group_name              = var.resource_group_name
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
    name              = "${var.orchestrator_name}-master-vm-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.orchestrator_name}-master"
    admin_username = var.orchestrator_name
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.orchestrator_name}/.ssh/authorized_keys"
      key_data = var.allowed_public_key
    }
  }

  tags = {
    orchestrator = var.orchestrator_name
  }
}

resource "azurerm_virtual_machine" "worker" {
  name                             = "${var.orchestrator_name}-worker-vm"
  location                         = var.resource_group_location
  resource_group_name              = var.resource_group_name
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
    name              = "${var.orchestrator_name}-worker-vm-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.orchestrator_name}-worker"
    admin_username = var.orchestrator_name
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.orchestrator_name}/.ssh/authorized_keys"
      key_data = var.allowed_public_key
    }
  }

  tags = {
    orchestrator = var.orchestrator_name
  }
}
