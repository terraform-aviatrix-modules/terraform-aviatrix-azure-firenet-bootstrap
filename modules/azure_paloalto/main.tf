#Random string for unique storage account
resource "random_string" "account" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "bootstrap" {
  name     = "bootstrap-${random_string.account.result}"
  location = var.region
}

resource "azurerm_storage_account" "bootstrap" {
  name                     = "bootstrappanw${random_string.account.result}"
  resource_group_name      = azurerm_resource_group.bootstrap.name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "bootstrap" {
  name                 = "bootstrap-panw-${random_string.account.result}"
  storage_account_name = azurerm_storage_account.bootstrap.name
}

resource "azurerm_storage_share_directory" "config" {
  name                 = "config"
  share_name           = azurerm_storage_share.bootstrap.name
  storage_account_name = azurerm_storage_account.bootstrap.name
}

resource "azurerm_storage_share_directory" "content" {
  name                 = "content"
  share_name           = azurerm_storage_share.bootstrap.name
  storage_account_name = azurerm_storage_account.bootstrap.name
}

resource "azurerm_storage_share_directory" "license" {
  name                 = "license"
  share_name           = azurerm_storage_share.bootstrap.name
  storage_account_name = azurerm_storage_account.bootstrap.name
}

resource "azurerm_storage_share_directory" "software" {
  name                 = "software"
  share_name           = azurerm_storage_share.bootstrap.name
  storage_account_name = azurerm_storage_account.bootstrap.name
}

resource "azurerm_storage_share_file" "xml" {
  name             = "bootstrap.xml"
  path             = "config"
  storage_share_id = azurerm_storage_share.bootstrap.id
  source           = "${path.module}/bootstrap-azure.xml"
}

resource "azurerm_storage_share_file" "cfg" {
  name             = "init-cfg.txt"
  path             = "config"
  storage_share_id = azurerm_storage_share.bootstrap.id
  source           = "${path.module}/init-cfg.txt"
}