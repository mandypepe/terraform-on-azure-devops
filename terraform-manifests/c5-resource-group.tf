# Resource-1: Azure Resource Group
data "azurerm_resource_group" "rg" {
  name = var.rg_despligue_name
}