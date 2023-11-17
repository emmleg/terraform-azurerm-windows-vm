output "id" {
  description = "The ID of the Virtual Machine."
  value       = azurerm_windows_virtual_machine.vm.id
}

output "name" {
  description = "The Name of the Virtual Machine."
  value       = azurerm_windows_virtual_machine.vm.name
}

output "computer_name" {
  description = "The Comuputer/Host name of the Virtual Machine."
  value       = azurerm_windows_virtual_machine.vm.computer_name
}

output "public_ip_address" {
  description = "Public IP Address of the Virtual Machine."
  value       = one(azurerm_public_ip.public_ip[*].ip_address)
}

output "private_ip_address" {
  description = "Private IP Address of the Virtual Machine."
  value       = try(azurerm_network_interface.nic.private_ip_address, null)
}
