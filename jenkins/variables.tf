variable "region" {
  description = "System region"
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "secgr_ports" {
  description = "Open ports"
  type = list
  default     = ["80", "22", "8080", "50000"]
}

variable "cidr" {
  description = "typical cidr block"
  type = list
  default     = ["0.0.0.0/0"]
}