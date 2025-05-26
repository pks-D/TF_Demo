terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }
}

provider "azurerm" {
  features {}
#   subscription_id = "e2f02d95-fd68-450b-8494-b1bed38c1aec"
}