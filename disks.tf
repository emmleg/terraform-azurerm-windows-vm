resource "azurerm_managed_disk" "disk" {
  for_each = var.data_disks

  location            = var.location
  resource_group_name = var.resource_group_name

  name = lower(format("%s-datadisk-%s", local.module_naming.vm_name, each.key))

  zone                 = can(regex("_zrs$", lower(each.value.storage_account_type))) ? null : var.zone_id
  storage_account_type = each.value.storage_account_type
  create_option        = each.value.create_option
  disk_size_gb         = each.value.disk_size_gb
  source_resource_id   = contains(["Copy", "Restore"], each.value.create_option) ? each.value.source_resource_id : null

  tags = merge(local.module_tags, var.tags)
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment" {
  for_each = var.data_disks

  managed_disk_id    = azurerm_managed_disk.disk[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id

  lun     = coalesce(each.value.lun, index(keys(var.data_disks), each.key))
  caching = each.value.caching
}
