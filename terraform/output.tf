

output "resource_group_name" {
  value = azurerm_resource_group.azure_rg.name
}

output "public_ip" {
  value = azurerm_public_ip.azure_pip.id
}

output "ssh_key_name" {
  value = azapi_resource.ssh_public_key.id
}

