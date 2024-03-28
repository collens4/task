# Create resource group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# Create AKS cluster
resource "azurerm_kubernetes_cluster" "example" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = var.aks_cluster_name
  kubernetes_version  = "1.22.6"

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = "Standard_DS2_v2"
    availability_zones = ["1", "2", "3"]
    enable_auto_scaling = true
    min_count = 1
    max_count = 5
    node_labels = {
      "type" = "slaves"
    }
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  service_principal {
    client_id     = "MYID"
    client_secret = "MYSECRET"
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    Environment = "Testing"
  }
}

# Create Azure File storage class
resource "kubernetes_storage_class" "azurefile" {
  metadata {
    name = "azurefile"
  }
  provisioner = "kubernetes.io/azure-file"
  parameters {
    skuName = "Standard_LRS"
  }
  storage_class_parameters {
    type = "Standard_LRS"
  }
}
