#Terraform Configuration

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.2"
    }
  }
    backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "<storage_account_name>"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
        access_key           = "access key" 
    }

}

provider "azurerm" {
  features {}
}

#Resource Group

resource "azurerm_resource_group" "state-demo-secure" {
  name     = "state-demo"
  location = var.location
}