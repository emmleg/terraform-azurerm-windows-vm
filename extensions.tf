resource "azurerm_virtual_machine_extension" "aad_login_windows" {
  count = var.enable_aad_login ? 1 : 0

  name                       = "AADLoginForWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = "2.0"
  auto_upgrade_minor_version = false
  automatic_upgrade_enabled  = false
}

resource "azurerm_virtual_machine_extension" "ad_domain_join" {
  count = var.ad_settings != null ? 1 : 0

  name                       = "ad_domain_join"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = false

  settings = <<-SETTINGS
    {
      "Name": "${var.ad_settings.domain}",
      "OUPath": "${var.ad_settings.ou_path}",
      "User": "${var.ad_settings.username}",
      "Restart": "true",
      "Options": "3"
    }
    SETTINGS

  protected_settings = <<-PROTECTED_SETTINGS
    {
      "Password": "${var.ad_settings.password}"
    }
    PROTECTED_SETTINGS

  lifecycle {
    ignore_changes = [settings, protected_settings]
  }
}
