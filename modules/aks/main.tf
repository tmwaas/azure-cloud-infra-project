resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name
  
  default_node_pool {
    name                = var.node_pool.name
    vm_size             = var.node_pool.vm_size

    enable_auto_scaling = true
    min_count           = var.node_pool.min_count
    max_count           = var.node_pool.max_count

    node_count          = null
    vnet_subnet_id      = var.subnet_id
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.1.0.0/16"
    dns_service_ip = "10.1.0.10"
  }

  identity { type = "SystemAssigned" }
  role_based_access_control_enabled = true
}

# resource "azurerm_role_assignment" "acr_pull" {
#  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
#  role_definition_name = "AcrPull"
#  scope                = var.acr_id
# }
