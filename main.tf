terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.47.0"
    }
  }
}

provider "azurerm" {
    subscription_id = "d153d766-5361-4b3f-a0dc-81df4d786ac9"
    tenant_id = "72f988bf-86f1-41af-91ab-2d7cd011db47"
    client_id = "ddce255a-9f6c-4115-ae54-f79f57347777"
    client_secret = "yMf8Q~exwr1vjZub-2dC4HBZfTMHIVXfepBQkdut"
    features {}   
}

locals {
  resource_group_name = "rg-terraform"
  location = "West Europe"
  virtual_network={
    name="terraformcrtudosevnet_v2"
    address_space = ["10.4.0.0/16"]
  }

  subnets=[
    {
      name = "SubnetA"
      address_prefix = "10.4.0.0/24"
    },
    {
      name = "SubnetB"
      address_prefix = "10.4.1.0/24"
    },
    {
      name = "SubnetC"
      address_prefix = "10.4.2.0/24"
    }
  ]
}

#variable "address_space"
# {
#  description = "VNET adress space"
#  type = string 
#  default = "project"
# }

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = local.location
}

#resource "azurerm_storage_account" "terra-SA" {
#  name                     = "terraformcrtudosesa"
#  resource_group_name      = "rg-terraform"
#  location                 = "West Europe"
#  account_tier             = "Standard"
#  account_replication_type = "LRS"
#  account_kind = "StorageV2"
#  depends_on = [azurerm_resource_group.rg  ]
#    }

#resource "azurerm_storage_container" "terra-container" {
#  name                  = "terraformcrtudosecontainer"
#  storage_account_name  = "terraformcrtudosesa"
#  container_access_type = "blob"
#  depends_on = [azurerm_storage_account.terra-SA  ]
#}

#resource "azurerm_storage_blob" "terra-blob" {
#  name                   = "terraformexe"
#  storage_account_name   = "terraformcrtudosesa"
#  storage_container_name = "terraformcrtudosecontainer"
#  type                   = "Block"
#  source                 = "terraform.exe"
#  depends_on = [azurerm_storage_container.terra-container  ]
#}

#resource "azurerm_network_security_group" "example" {
#  name                = "terraformcrtudoseNSG"
#  location            = "West Europe"
#  resource_group_name = "rg-terraform"
#

resource "azurerm_virtual_network" "terra-vnet" {
  name                = local.virtual_network.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = local.virtual_network.address_space
 # dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = local.subnets[0].name
    address_prefix = local.subnets[0].address_prefix
  }

    subnet {
    name           = local.subnets[1].name
    address_prefix = local.subnets[1].address_prefix
  }

      subnet {
    name           = local.subnets[2].name
    address_prefix = local.subnets[2].address_prefix
  }

#    subnet {
#    name           = "subnetA"
#    address_prefix = "10.3.0.0/24"
#    security_group = azurerm_network_security_group.example.id
#  }

#  subnet {
#    name           = "subnetB"
#    address_prefix = "10.3.1.0/24"
#    security_group = azurerm_network_security_group.example.id
#  }
  depends_on = [
    azurerm_resource_group.rg
  ]

#  tags = {
#    environment = "Production"
#  }
}