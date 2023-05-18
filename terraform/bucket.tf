resource "azurerm_storage_account" "cloud_computing_files" {
  name                     = "cloudcomputingfiles"
  resource_group_name      = azurerm_resource_group.cloud.name
  location                 = azurerm_resource_group.cloud.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "containerd_driver" {
  name                  = "containerd-driver"
  storage_account_name  = azurerm_storage_account.cloud_computing_files.name
  container_access_type = "blob"
}
