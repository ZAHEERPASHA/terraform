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
  default     = "dev"
}

variable "virtual_network_name" {
  description = "virtual network name"
  default     = "sample-Vnet"
}



variable "vnet_address_space" {
  default = "10.0.0.0/16"
}


variable "subnet_prefix" {
    default = [
        "10.0.1.0/24",
        "10.0.2.0/24"
    ]
} 


variable "azurerm_vm_name" {
  description = "Virtual Machine Name. This will be the prefix"
  default     = "testvm"
}

variable "azurerm_vm_size" {
  description = "Azure VM Size"
  default     = "Standard_DS1_v2"
  type        = string
}
variable azurerm_vm_managed_disk_type {
  description = "Enter type of managed disk"
  default     = "Standard_LRS"
  type        = string
}

variable azure_vm_delete_os_disk_on_termination {
  description = "Whether to delete os disk on VM termination"
  default     = true
  type        = bool
}

variable azure_vm_delete_data_disks_on_termination {
  description = "Whether to delete data disk on VM termination"
  default     = false
  type        = bool
}

variable "azurerm_vm_disk_size" {
  description = "Size of the OS Disk in GB"
  default     = "128"
}

variable azurerm_vm_username {
  type = string
  default     = "azureuser"
}

variable azurerm_vm_password {
  type = string
  default     = "azurepassword"
}

