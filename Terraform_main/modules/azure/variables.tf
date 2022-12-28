variable "resource_group_name" {
  description = "Resource group name"
  default     = "Grafana"
}
variable "res_group_location" {
  description = "Resource group location"
  default     = "West Europe"
}
variable "size" {
  description = "Size instance"
  default     = "Standard_B1s"
}
variable "user_data" {
  description = "Source user_data"
  type        = string
  default     = "userdata.sh"
}
variable "public_key" {
  description = "Source public key"
  default     = "userdata/onekey.pub"
}
variable "image_publisher" {
  description = "Image publisher"
  default     = "OpenLogic"
}
variable "image_offer" {
  description = "Image offer"
  default     = "CentOS"
}
