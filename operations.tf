resource "azurerm_dev_test_global_vm_shutdown_schedule" "vm" {
  count              = var.vm_shutdown_schedule == null ? 0 : 1
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  location           = var.location
  enabled            = true

  daily_recurrence_time = var.vm_shutdown_schedule.daily_recurrence_time
  timezone              = var.vm_shutdown_schedule.timezone

  notification_settings {
    enabled         = var.vm_shutdown_schedule.notifications == null ? false : true
    time_in_minutes = try(var.vm_shutdown_schedule.notifications.time_in_minutes, null)
    webhook_url     = try(var.vm_shutdown_schedule.notifications.webhook_url, null)
    email           = try(var.vm_shutdown_schedule.notifications.email, null)
  }
}
