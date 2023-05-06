terraform {
  backend "azurerm" {
    resource_group_name  = "cloud-computing"
    storage_account_name = "cloudtf"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "cloud" {
  name     = "cloud-computing"
  location = "Japan East"

  tags = {
    orchestrator = "k3s"
  }
}
