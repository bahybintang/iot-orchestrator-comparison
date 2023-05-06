output "master_ip" {
  value = azurerm_public_ip.k3s_master.ip_address
}

output "nat_ip" {
  value = azurerm_public_ip.nat.ip_address
}
