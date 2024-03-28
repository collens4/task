resource "azurerm_log_analytics_workspace" "example" {
  name                = "my-log-analytics-workspace"
  location            = "East US"
  resource_group_name = "my-resource-group"
}

resource "azurerm_kubernetes_cluster" "example" {
  # Other AKS configurations...
  monitoring_workspace_id = azurerm_log_analytics_workspace.example.id
}

# AZURE MONITORING AND LOGGING ALERTS
resource "azurerm_monitor_metric_alert" "example" {
  name                = "example-alert"
  resource_group_name = "my-resource-group"
  scopes              = [azurerm_kubernetes_cluster.example.id]
  description         = "Alert triggered when CPU usage exceeds 80% for 5 minutes"
  severity            = 2
  enabled             = true

  criteria {
    metric_namespace = "ContainerInsights"
    metric_name      = "cpuUsage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
    time_aggregation = "Average"
    operator         = "GreaterThan"
    threshold        = 80
    time_grain       = "PT1M"
  }

  action {
    action_group_id = azurerm_monitor_action_group.example.id
  }
}

# We Create alerts based on Log Analytics queries to detect specific events
resource "azurerm_monitor_metric_alert" "example" {
  # Alert configuration...
}

# We define action groups in Azure Monitor to specify the actions to be taken when an alert is triggered.
resource "azurerm_monitor_action_group" "example" {
  name                = "example-action-group"
  resource_group_name = "my-resource-group"

  email_receiver {
    name          = "example-email-receiver"
    email_address = "example@example.com"
  }
}

# Implement Role-Based Access Control(In this role, contributor access was given)
we create RBAC roles and role assignments for Azure resources using Terraform.
resource "azurerm_role_assignment" "example" {
  scope                = azurerm_log_analytics_workspace.example.id
  role_definition_name = "Contributor"
  principal_id         = "PRINCIPAL_ID"
}

