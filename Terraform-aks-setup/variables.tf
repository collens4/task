# Define variables
variable "resource_group_name" {
  default = "my-resource-group"
}

variable "location" {
  default = "East US"
}

variable "aks_cluster_name" {
  default = "my-aks-cluster"
}

variable "aks_node_count" {
  default = 3
}
