terraform {
  backend "azurerm" {
    resource_group_name  = "cloud-computing-nomad"
    storage_account_name = "cloudtfnomad"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "cloud" {
  name     = "cloud-computing-nomad"
  location = "Japan East"

  tags = {
    orchestrator = "nomad"
  }
}
