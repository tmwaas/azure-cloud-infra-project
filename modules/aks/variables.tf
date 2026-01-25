variable "cluster_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "acr_id" {}

variable "node_pool" {
  type = object({
    name       = string
    vm_size   = string
    node_count = number
    min_count  = number
    max_count  = number
  })
}
