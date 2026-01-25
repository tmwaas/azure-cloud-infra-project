data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

module "network" {
  source              = "../modules/network"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  vnet_name           = "aks-vnet"
  vnet_cidr           = "10.0.0.0/16"
  aks_subnet_cidr     = "10.0.1.0/24"
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

module "aks" {
  source              = "../modules/aks"
  cluster_name        = var.cluster_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = module.network.aks_subnet_id
  acr_id              = azurerm_container_registry.acr.id

  node_pool = {
    name        = "default"
    vm_size     = "Standard_DS2_v2"
    node_count  = null
    min_count   = 1
    max_count   = 3
  }
}
