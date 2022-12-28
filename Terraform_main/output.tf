output "AWS_public_ip" {
  value = module.aws_Grafana.web_load_balancer
}
output "Azure_Public_IP" {
  value = module.azure_Grafana.public_ip
}