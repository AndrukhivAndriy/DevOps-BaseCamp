output "ec2_global_ip" {
  value = ["${aws_instance.jenkins_server.public_ip}"]
}