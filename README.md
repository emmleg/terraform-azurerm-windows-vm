<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.60.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_backup_protected_vm.backup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_vm) | resource |
| [azurerm_dev_test_global_vm_shutdown_schedule.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dev_test_global_vm_shutdown_schedule) | resource |
| [azurerm_managed_disk.disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_application_gateway_backend_address_pool_association.appgw_pool_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_application_gateway_backend_address_pool_association) | resource |
| [azurerm_network_interface_backend_address_pool_association.lb_pool_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association) | resource |
| [azurerm_network_interface_security_group_association.nic_nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_machine_data_disk_attachment.data_disk_attachment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_extension.aad_login_windows](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.ad_domain_join](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ad_settings"></a> [ad\_settings](#input\_ad\_settings) | (Optional) Active Directory (ADDS) settings to join the virtual machine to a domain. | <pre>object({<br>    domain   = string<br>    username = string<br>    password = string<br>    ou_path  = optional(string, "")<br>  })</pre> | `null` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | (Required) The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_application_gateway_backend_pool_id"></a> [application\_gateway\_backend\_pool\_id](#input\_application\_gateway\_backend\_pool\_id) | (Optional) Backend pool ID of the application gateway. The variable 'attach\_application\_gateway' should be set to 'true'. | `string` | `null` | no |
| <a name="input_attach_application_gateway"></a> [attach\_application\_gateway](#input\_attach\_application\_gateway) | (Optional) A boolean to attach or not the virtual machine network interface to an application gateway. Default to 'false'. | `bool` | `false` | no |
| <a name="input_attach_load_balancer"></a> [attach\_load\_balancer](#input\_attach\_load\_balancer) | (Optional) A boolean to attach or not the virtual machine network interface to a load balancer. Default to 'false'. | `bool` | `false` | no |
| <a name="input_availability_set_id"></a> [availability\_set\_id](#input\_availability\_set\_id) | (Optional) Specifies the ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_backup_policy_id"></a> [backup\_policy\_id](#input\_backup\_policy\_id) | (Optional) Recovery Service Vault backup policy ID for the virtual machine. | `string` | `null` | no |
| <a name="input_boot_diagnostics"></a> [boot\_diagnostics](#input\_boot\_diagnostics) | (Optional) Boot diagnostic block. Leaving 'enable' to true and 'storage\_account\_uri' empty will result in Managed Storage Account to store Boot Diagnostics. Default to disabled. | <pre>object({<br>    enable              = bool<br>    storage_account_uri = optional(string, null)<br>  })</pre> | <pre>{<br>  "enable": false<br>}</pre> | no |
| <a name="input_data_disks"></a> [data\_disks](#input\_data\_disks) | (Optional) Data disk map of objects to create and attach managed disks to the virtual machine. | <pre>map(object({<br>    name                 = optional(string)<br>    create_option        = optional(string, "Empty")<br>    disk_size_gb         = number<br>    lun                  = optional(number)<br>    caching              = optional(string, "ReadWrite")<br>    storage_account_type = optional(string, "StandardSSD_LRS")<br>    source_resource_id   = optional(string)<br>    extra_tags           = optional(map(string), {})<br>  }))</pre> | `{}` | no |
| <a name="input_domain_dns_label"></a> [domain\_dns\_label](#input\_domain\_dns\_label) | (Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system. | `string` | `""` | no |
| <a name="input_enable_aad_login"></a> [enable\_aad\_login](#input\_enable\_aad\_login) | (Optional) Enable Azure AD / Entra AD login on the virtual machine. Default to 'false'. | `bool` | `false` | no |
| <a name="input_enable_accelerated_networking"></a> [enable\_accelerated\_networking](#input\_enable\_accelerated\_networking) | (Optional) Should Accelerated Networking be enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_module_tags"></a> [enable\_module\_tags](#input\_enable\_module\_tags) | (Optional) Enable or not built-in mapping of tags which should be assigned to the Virtual Machine. Default to 'true'. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Configuration block in which you can specify the type of Managed Service Identity that should be configured on this Windows Virtual Machine. Default to value for type is ''SystemAssigned. | <pre>object({<br>    type         = string<br>    identity_ids = list(string)<br>  })</pre> | <pre>{<br>  "identity_ids": [],<br>  "type": "SystemAssigned"<br>}</pre> | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | (Optional) Specifies the type of on-premise license (also known as Azure Hybrid Use Benefit) which should be used for this Virtual Machine. Possible values are None, Windows\_Client and Windows\_Server. | `string` | `null` | no |
| <a name="input_load_balancer_backend_pool_id"></a> [load\_balancer\_backend\_pool\_id](#input\_load\_balancer\_backend\_pool\_id) | (Optional) Backend pool ID of the load balancer. The variable 'attach\_load\_balancer' should be set to 'true'. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure location where the Windows Virtual Machine should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_nic_nsg_id"></a> [nic\_nsg\_id](#input\_nic\_nsg\_id) | (Optional) The ID of the Network Security Group which should be attached to the Network Interface. | `string` | `null` | no |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | (Optional) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite. Default to 'ReadWrite'. | `string` | `"ReadWrite"` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | (Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. | `string` | `null` | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | (Optional) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard\_LRS, StandardSSD\_LRS, Premium\_LRS, StandardSSD\_ZRS and Premium\_ZRS. Changing this forces a new resource to be created.Default to 'Standard\_LRS'. | `string` | `"Standard_LRS"` | no |
| <a name="input_public_ip_sku"></a> [public\_ip\_sku](#input\_public\_ip\_sku) | n/a | `string` | `"Standard"` | no |
| <a name="input_public_ip_zones"></a> [public\_ip\_zones](#input\_public\_ip\_zones) | (Optional) A collection containing the availability zone to allocate the Public IP in. Changing this forces a new resource to be created. | `list(number)` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which the Windows Virtual Machine should be exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | (Required) The SKU which should be used for this Virtual Machine. | `string` | n/a | yes |
| <a name="input_source_image_id"></a> [source\_image\_id](#input\_source\_image\_id) | (Optional) The ID of the Image which this Virtual Machine should be created from. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_static_private_ip"></a> [static\_private\_ip](#input\_static\_private\_ip) | (Optional) The Static IP Address which should be used. | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) The ID of the Subnet where this Network Interface should be located in. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Virtual Machine. | `map(string)` | `{}` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | (Optional) Specifies the Time Zone which should be used by the Virtual Machine. | `string` | `null` | no |
| <a name="input_vm_hostname"></a> [vm\_hostname](#input\_vm\_hostname) | (Required) Specifies the Hostname which should be used for this Virtual Machine. | `string` | n/a | yes |
| <a name="input_vm_image"></a> [vm\_image](#input\_vm\_image) | (Optional) An equivalent of the 'source\_image\_reference' block. | `map(string)` | <pre>{<br>  "offer": "WindowsServer",<br>  "publisher": "MicrosoftWindowsServer",<br>  "sku": "2019-Datacenter",<br>  "version": "latest"<br>}</pre> | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | (Required) The name of the Windows Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_vm_plan"></a> [vm\_plan](#input\_vm\_plan) | (Optional) An equivalent of the 'plan' block. | <pre>object({<br>    name      = string<br>    product   = string<br>    publisher = string<br>  })</pre> | `null` | no |
| <a name="input_vm_shutdown_schedule"></a> [vm\_shutdown\_schedule](#input\_vm\_shutdown\_schedule) | (Optional) Virtual Machine shutdown schedule if needed. | <pre>object({<br>    daily_recurrence_time = string<br>    timezone              = optional(string, "UTC")<br>    notifications = optional(object({<br>      email           = optional(string)<br>      time_in_minutes = optional(number)<br>      webhook_url     = optional(string)<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | (Optional) Specifies the Availability Zone in which this Windows Virtual Machine should be located. Changing this forces a new Windows Virtual Machine to be created. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_computer_name"></a> [computer\_name](#output\_computer\_name) | The Comuputer/Host name of the Virtual Machine. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual Machine. |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Virtual Machine. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | Private IP Address of the Virtual Machine. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | Public IP Address of the Virtual Machine. |
<!-- END_TF_DOCS -->