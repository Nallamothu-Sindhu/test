terraform {
  required_providers {
     azurerm = {
      source = "hashicorp/azurerm"
      version = "4.45.1"
     }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7fbf171c-9299-4282-9415-3f7dee43e4dd"
}

resource "azurerm_resource_group" "rg" {
    name = "rg-docker-test"
    location = "Central US"
  
}

resource "azurerm_container_registry" "acr-test" {
    name = "azurecoontainertestone"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    sku =  "Basic"
    admin_enabled = true
  
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "demo-aks1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s.kube_config_raw

  sensitive = true
}

