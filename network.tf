resource "azurerm_public_ip" "public_ip" {
  count = var.public_ip_sku == null ? 0 : 1

  name                = local.module_naming.vm_pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = coalesce(var.domain_dns_label, local.module_naming.vm_name)
  sku                 = var.public_ip_sku
  zones               = var.public_ip_zones

  tags = merge(local.module_tags, var.tags)
}

resource "azurerm_network_interface" "nic" {
  name                = local.module_naming.vm_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  enable_accelerated_networking = var.enable_accelerated_networking
  tags                          = merge(local.module_tags, var.tags)

  ip_configuration {
    name                          = local.module_naming.vm_ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.static_private_ip == null ? "Dynamic" : "Static"
    private_ip_address            = var.static_private_ip
    public_ip_address_id          = one(azurerm_public_ip.public_ip[*].id)
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_association" {
  count = var.nic_nsg_id == null ? 0 : 1

  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.nic_nsg_id
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_pool_association" {
  count = var.attach_load_balancer ? 1 : 0

  backend_address_pool_id = var.load_balancer_backend_pool_id
  ip_configuration_name   = local.module_naming.vm_ip_configuration_name
  network_interface_id    = azurerm_network_interface.nic.id
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "appgw_pool_association" {
  count = var.attach_application_gateway ? 1 : 0

  backend_address_pool_id = var.application_gateway_backend_pool_id
  ip_configuration_name   = local.module_naming.vm_ip_configuration_name
  network_interface_id    = azurerm_network_interface.nic.id
}