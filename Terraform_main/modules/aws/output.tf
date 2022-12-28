output "web_load_balancer" {
    value = aws_elb.Grafana-Load-Balancer.dns_name
  
}
output "latest_ami_name" {
    value = data.aws_ami.amazon_linux_latest.name
}