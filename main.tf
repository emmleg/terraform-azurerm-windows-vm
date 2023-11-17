resource "azurerm_windows_virtual_machine" "vm" {
  name                = local.module_naming.vm_name
  computer_name       = local.module_naming.vm_hostname
  location            = var.location
  resource_group_name = var.resource_group_name

  admin_username        = var.admin_username
  admin_password        = var.admin_password
  availability_set_id   = var.availability_set_id
  license_type          = var.license_type
  network_interface_ids = [azurerm_network_interface.nic.id]
  provision_vm_agent    = true
  size                  = var.size
  source_image_id       = var.source_image_id
  timezone              = var.timezone
  zone                  = var.zone_id
  tags                  = merge(local.module_tags, var.tags)

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics.enable ? [1] : []
    content {
      storage_account_uri = var.boot_diagnostics.storage_account_uri
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? ["disabled"] : []
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }

  os_disk {
    name                 = local.module_naming.vm_os_disk_name
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb         = var.os_disk_size_gb
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_id == null ? ["disabled"] : []
    content {
      offer     = lookup(var.vm_image, "offer", null)
      publisher = lookup(var.vm_image, "publisher", null)
      sku       = lookup(var.vm_image, "sku", null)
      version   = lookup(var.vm_image, "version", null)
    }
  }

  dynamic "plan" {
    for_each = var.vm_plan[*]
    content {
      name      = var.vm_plan.name
      product   = var.vm_plan.product
      publisher = var.vm_plan.publisher
    }
  }
}
