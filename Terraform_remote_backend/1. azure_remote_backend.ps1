#Azure Stoargae Terraform Remote Backend Creation Script"
#https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=powershell#

$RESOURCE_GROUP_NAME='tfstate'
$STORAGE_ACCOUNT_NAME="tfstate$(Get-Random)"
$CONTAINER_NAME='tfstate'
$Location='uksouth'

# Create resource group
New-AzResourceGroup -Name $RESOURCE_GROUP_NAME -Location eastus

# Create storage account
$storageAccount = New-AzStorageAccount -ResourceGroupName $RESOURCE_GROUP_NAME -Name $STORAGE_ACCOUNT_NAME -SkuName Standard_LRS -Location $Location -AllowBlobPublicAccess $true

# Create blob container
New-AzStorageContainer -Name $CONTAINER_NAME -Context $storageAccount.context -Permission blob




