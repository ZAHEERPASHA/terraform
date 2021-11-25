what are the different artifacts you need to create - name of the artifacts and its purpose

main.tf -- will contain the main set of configuration for your module.
var.tf  -- Variable declarations and types
provider.tf  -- terraform plugins to interact with remote system
tfvars.tf  --  is used to set the actual values of the variables



list of tools you will create amd store the terraform templates
Git repository -- to version terraform files
Storage account & Container -- to version & store backend tfstate files
Az App registration -- to manage authorization/permissions to provision resources in Subscription 


explain the process and steps to create automated deployment pipelines ?
 - Verion control files in GitHub
 - Create CI pipeline and refer git sources
 - Create the yaml deployment pipeline
	- Add terraform task.
	- provide resource details to preserve backend statefile
 	- provide inputs to call terraform scripts
