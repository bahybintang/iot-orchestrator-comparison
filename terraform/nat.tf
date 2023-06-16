resource "azurerm_public_ip" "nat" {
  name                = "nat-gateway-public-ip"
  location            = azurerm_resource_group.cloud.location
  resource_group_name = azurerm_resource_group.cloud.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

# resource "azurerm_nat_gateway" "nat" {
#   name                    = "nat-gateway"
#   location                = azurerm_resource_group.cloud.location
#   resource_group_name     = azurerm_resource_group.cloud.name
#   sku_name                = "Standard"
#   idle_timeout_in_minutes = 10
#   zones                   = ["1"]
# }

# resource "azurerm_nat_gateway_public_ip_association" "nat" {
#   nat_gateway_id       = azurerm_nat_gateway.nat.id
#   public_ip_address_id = azurerm_public_ip.nat.id
# }

# resource "azurerm_subnet_nat_gateway_association" "nat" {
#   subnet_id      = azurerm_subnet.internal.id
#   nat_gateway_id = azurerm_nat_gateway.nat.id
# }
