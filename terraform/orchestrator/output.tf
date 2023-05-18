output "master_ip" {
  value = azurerm_public_ip.master.ip_address
}

output "master_ip_private" {
  value = azurerm_network_interface.external.private_ip_address
}

output "worker_ip_private" {
  value = azurerm_network_interface.internal.private_ip_address
}
