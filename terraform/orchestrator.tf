locals {
  orchestrators = [
    {
      orchestrator_name        = "kubeedge"
      allowed_ports            = [22, 2379, 2380, 6443, 8472, 10250, 51820, 51821, 51871]
      allowed_source_addresses = ["10.0", "10.112", "103.82.14.237", "122.11.166.8", azurerm_public_ip.nat.ip_address]
    },
    {
      orchestrator_name        = "nomad"
      allowed_ports            = [22, 4646, 4647, 4648, 51871]
      allowed_source_addresses = ["10.0", "10.112", "103.82.14.237", "122.11.166.8", azurerm_public_ip.nat.ip_address]
    },
    # {
    #   orchestrator_name        = "k3s"
    #   allowed_ports            = [22, 2379, 2380, 6443, 8472, 10250, 51820, 51821, 51871]
    #   allowed_source_addresses = ["10.0", "10.112", "103.82.14.237", azurerm_public_ip.nat.ip_address]
    # }
  ]
}

module "orchestrator" {
  count                    = length(local.orchestrators)
  source                   = "./orchestrator"
  orchestrator_name        = local.orchestrators[count.index].orchestrator_name
  allowed_ports            = local.orchestrators[count.index].allowed_ports
  allowed_source_addresses = local.orchestrators[count.index].allowed_source_addresses
  resource_group_name      = azurerm_resource_group.cloud.name
  resource_group_location  = azurerm_resource_group.cloud.location
  allowed_public_key       = azurerm_ssh_public_key.main.public_key
  internal_subnet_id       = azurerm_subnet.internal.id
  external_subnet_id       = azurerm_subnet.external.id
}
