resource "azurerm_ssh_public_key" "main" {
  name                = "main"
  resource_group_name = azurerm_resource_group.cloud.name
  location            = azurerm_resource_group.cloud.location
  public_key          = file("~/.ssh/id_rsa.pub")
}
