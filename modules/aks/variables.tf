variable "cluster_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "acr_id" {
  type = string
}

variable "node_pool" {
  type = object({
    name       = string
    vm_size    = string
    min_count  = number
    max_count  = number
  })
}
