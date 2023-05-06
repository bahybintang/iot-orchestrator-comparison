terraform {
  backend "azurerm" {
    resource_group_name  = "cloud-computing-kubeedge"
    storage_account_name = "cloudtfkubeedge"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "cloud" {
  name     = "cloud-computing-kubeedge"
  location = "Japan East"

  tags = {
    orchestrator = "kubeedge"
  }
}
