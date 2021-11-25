variable "tenant_id" {
  description = "A variable that holds azure tenant ID"
  default     = ""
}

variable "subscription_id" {
  description = "A variable that holds azure subscription ID"
  default     = ""
}

variable "client_id" {
  description = "A variable that holds azure client IDn"
  default     = ""
}
variable "password" {
  description = "password"
  default     = ""
}


variable "client_secret" {
  description = "A variable that holds azure secret"
  default     = ""
}

variable "resource_group_name" {
  description = "A variable that holds azure secret"
  default     = "sample-rg"
}

variable "location" {
  description = "region"
  default     = "west us"
}

variable "env" {
  description = "A variable that holds env"
  default     = "qa"
}

variable "virtual_network_name" {
  description = "virtual network name"
  default     = "CSP-FAPM-NonProd-Vnet"
}

variable "network_config" {
  description = "network configuration details"
  type        = map(string)
  default     = {resource_group_name = "HPS-TestCA-Dev-USWest-2.0" , vnet_name = "HPS-TestCA-Dev-USWest-2.0",subnet_name = "TestCA-Group2-2.0"}
}