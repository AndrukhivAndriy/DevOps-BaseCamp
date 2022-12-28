output "public_ip" {
  value = azurerm_public_ip.grafana_public_ip.ip_address
}