what are the different artifacts you need to create - name of the artifacts and its purpose

main.tf -- will contain the main set of configuration for your module.
var.tf  -- Variable declarations and types
provider.tf  -- terraform plugins to interact with remote system
tfvars.tf  --  is used to set the actual values of the variables



list of tools you will create amd store the terraform templates
Git repository -- to version terraform files
Storage account & Container -- to version & store backend tfstate files
Az App registration -- to manage authorization/permissions to provision resources in Subscription 
Key vault to manage secrets

explain the process and steps to create automated deployment pipelines ?
 - Verion control files in GitHub
 - Create Release pipeline and add github source as an artifact
 - Add Terraform task to release job
 - Link key vault to linked variables
 - Create the yaml deployment pipeline
	- Add terraform task.
	- provide storage account details to preserve backend statefile
 	- provide inputs to call terraform scripts

Explain how will you access the passwd stored in the keyvault and use it as admin passwd in the VM terraform template
Approach#1:
- read secrets from vault in to tfvars file and use it as a variable in terraform script

Approach#2:
- Terraform data block to access key vault objects and secrets and use it as output value.