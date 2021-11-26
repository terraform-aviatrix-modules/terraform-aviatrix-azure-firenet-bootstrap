output "bootstrap_storage_name" {
  value = azurerm_storage_account.bootstrap.name
}

output "storage_access_key" {
  value = azurerm_storage_account.bootstrap.primary_access_key
}

output "file_share_folder" {
  value = azurerm_storage_share.bootstrap.name
}