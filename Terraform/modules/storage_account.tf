#Azure Storage Account Refrence#
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#


#Azure Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}


#Azure Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}