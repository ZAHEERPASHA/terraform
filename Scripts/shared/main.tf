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


##################################################################
#Terraform data block to read secret from vault.  
##################################################################

data "azurerm_key_vault" "keyvault" {
  name                = "testkeyva"
  resource_group_name = "csp-test-rsg"
}

data "azurerm_key_vault_secret" "passwd" {
  name         = "password"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
output "secret_value" {
  value = data.azurerm_key_vault_secret.passwd.value
  sensitive               = true
}

##################################################################
#Terraform create RG, VNET, subnet, Nic, VM 
##################################################################

resource "azurerm_resource_group" "sample-rg" {
  name     = "${data.azurerm_key_vault_secret.passwd.value}"
  location = "West US"
}


resource "azurerm_virtual_network" "vnet" {
  name                = "vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.sample-rg.location
  resource_group_name = azurerm_resource_group.sample-rg.name
}


resource "azurerm_subnet" "subnet" {
  count                = "${length(var.subnet_prefix)}"
  name                 = "subnet-${count.index}"
  resource_group_name  = azurerm_resource_group.sample-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  #address_prefixes     = "${element(var.subnet_prefix, count.index)}"
  address_prefixes     = [var.subnet_prefix[count.index]]
  }

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg1"
  location            = azurerm_resource_group.sample-rg.location
  resource_group_name = azurerm_resource_group.sample-rg.name
}
 
resource "azurerm_network_security_rule" "network-rule" {
  name                        = "test123"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443"]
  #destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sample-rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}


resource "azurerm_storage_account" "storageaccount" {
  name                     = "stgaccnt1"
  resource_group_name      = azurerm_resource_group.sample-rg.name
  location                 = azurerm_resource_group.sample-rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "dev"
  }
}


resource "azurerm_network_interface" "nic" {
	count = 2
    name                = "${var.azurerm_vm_name}-nic-${count.index}"
    location            = azurerm_resource_group.sample-rg.location
    resource_group_name = azurerm_resource_group.sample-rg.name

    ip_configuration {
        name                           = "${var.azurerm_vm_name}-nic-config"
        #subnet_id                     = var.azurerm_vnet_subnet_id
		subnet_id                      = "${azurerm_subnet.subnet[count.index].id}"
        private_ip_address_allocation  = "dynamic"
    }
}


resource "azurerm_windows_virtual_machine" "vm" {
    count                   = 2
    name                    = "${var.azurerm_vm_name}-${count.index}"
    location                = azurerm_resource_group.sample-rg.location
    resource_group_name     = azurerm_resource_group.sample-rg.name
    network_interface_ids   = [azurerm_network_interface.nic.*.id[count.index],]
    size                 = var.azurerm_vm_size
    admin_username = var.azurerm_vm_username
    admin_password = "${data.azurerm_key_vault_secret.passwd.value}"
    #delete_os_disk_on_termination    = var.azure_vm_delete_os_disk_on_termination
    #delete_data_disks_on_termination = var.azure_vm_delete_data_disks_on_termination

	
    os_disk {
        name              = "${var.azurerm_vm_name}-osdisk-${count.index}"
        caching           = "ReadWrite"
        disk_size_gb      = var.azurerm_vm_disk_size
		storage_account_type = "Standard_LRS"
    }

	source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  
  license_type = "Windows_Server"
}
