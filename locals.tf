locals {
  backup_resource_group_name = var.backup_policy_id != null ? split("/", var.backup_policy_id)[4] : null
  backup_recovery_vault_name = var.backup_policy_id != null ? split("/", var.backup_policy_id)[8] : null

  module_naming = {
    vm_name                  = lower(format("vmw%s", var.vm_name))
    vm_hostname              = lower(format("vmw%s", var.vm_hostname))
    vm_os_disk_name          = lower(format("vmw%s-osdisk", var.vm_name))
    vm_nic_name              = lower(format("vmw%s-nic", var.vm_name))
    vm_pip_name              = lower(format("vmw%s-pip", var.vm_name))
    vm_ip_configuration_name = lower(format("vmw%s-ipconfig", var.vm_name))
  }

  module_tags = var.enable_module_tags ? {
    deployment = "terraform"
  } : {}
}
