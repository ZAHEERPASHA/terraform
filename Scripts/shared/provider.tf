
#variables for authentication can be passed during runtime as terraform apply -var="subscription_id= XXXXXXXXXX"  
#else add all variables to a file  variables.tfvars and run terraform apply -var-file="variables.tfvars"
provider "azurerm" {
    subscription_id =  var.subscription_id
    client_id       =  var.client_id
    client_secret   =  var.client_secret
    tenant_id       =  var.tenant_id
    features {
      key_vault {
         purge_soft_delete_on_destroy = true
     } 
    }
}         

provider "azuread" {
    client_id       =  var.client_id
    client_secret   =  var.client_secret
    tenant_id       =  var.tenant_id
}

