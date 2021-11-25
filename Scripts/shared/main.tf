#This terraform script deploy Shared PAAS resources in Azure-Nonprod HCE-CPLT-APM-NONPROD

##################################################################
#Terraform remote state file which is stored in Azure blob storage.  
##################################################################
terraform {   
  backend "azurerm" {
    access_key            = "GeaLB4CKYtmFcnoLl8D/c7chh6EE33RoNdLMrOBW5LmYS1HZODtsUIiurFuU5MuOglzreHqc3G5G3LQW7xQkmA=="
    resource_group_name   = "csp-forgeapm-remotestate-rg"
    storage_account_name  = "cspforgeapmtfstate" 
    container_name        = "fapmtest"
    key                   = "samplerg2"
  }  
}


resource "azurerm_resource_group" "sample-rg" {
  name     = ${var.password}
  location = "West US"
}
