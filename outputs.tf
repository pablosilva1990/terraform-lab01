output "IP-VM-LINUX" {
  value = azurerm_public_ip.pib_lab01.ip_address
}

output "IP-VM-WIN" {
  value = azurerm_public_ip.pib_2_lab01.ip_address
}