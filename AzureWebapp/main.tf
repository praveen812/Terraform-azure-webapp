provider "azure_rm" {
  version = "3.0.0"

  subscription_id = "f4cc3e63-ae81-4c68-9d78-d189798870b4"
  client_id       = "07b54aec-e7df-43e1-ab0b-33c704349694"
  client_secret   = "UkG8Q~gGRSzznn5SOH~Wknt3CRzYpPfhjCnmVdxv"
  tenant_id       = "846b3d51-7341-4e24-932c-c0faeb6300a0"

  features {}
}


resource "azurerm_resource_group" "example1" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_app_service_plan" "example1" {
  name                = "example-appserviceplan1"
  location            = azurerm_resource_group.example1.location
  resource_group_name = azurerm_resource_group.example1.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example1" {
  name                = "example-app-service1234567890001"
  location            = azurerm_resource_group.example1.location
  resource_group_name = azurerm_resource_group.example1.name
  app_service_plan_id = azurerm_app_service_plan.example1.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
