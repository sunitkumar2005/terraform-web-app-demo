terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.47.0"
    }
  }
}

provider "azurerm" {
  features {
 app_configuration {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted         = true
    }
   }  
}

resource "azurerm_resource_group" "sunit-pip-rg" {
  name     = "sunit-pip-rg-terraform"
  location = "West Europe"
}

resource "azurerm_service_plan" "asp_web_name" {
  name                = "asp_web_name-sunit"
  resource_group_name = azurerm_resource_group.sunit-pip-rg.name
  location            = azurerm_resource_group.sunit-pip-rg.location
  sku_name            = "P1v2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "web-name-sunit" {
  name                = "web-name-sunit"
  resource_group_name = azurerm_resource_group.sunit-pip-rg.name
  location            = azurerm_service_plan.asp_web_name.location
  service_plan_id     = azurerm_service_plan.asp_web_name.id  
  site_config {   
  } 
}

resource "azurerm_app_configuration" "appconf" {
  name                = "App-Conf-sunit"
  resource_group_name = azurerm_resource_group.sunit-pip-rg.name
  location            = azurerm_resource_group.sunit-pip-rg.location

}