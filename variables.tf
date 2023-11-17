variable "vm_name" {
  description = "(Required) The name of the Windows Virtual Machine. Changing this forces a new resource to be created."
  type        = string
}

variable "vm_hostname" {
  description = "(Required) Specifies the Hostname which should be used for this Virtual Machine."
  type        = string
}

variable "location" {
  description = "(Required) The Azure location where the Windows Virtual Machine should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group in which the Windows Virtual Machine should be exist. Changing this forces a new resource to be created."
  type        = string
}

variable "admin_username" {
  description = "(Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
  type        = string
}

variable "admin_password" {
  description = "(Required) The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created."
  type        = string
}

variable "size" {
  description = "(Required) The SKU which should be used for this Virtual Machine."
  type        = string
}

variable "subnet_id" {
  description = "(Required) The ID of the Subnet where this Network Interface should be located in."
  type        = string
}

variable "availability_set_id" {
  description = "(Optional) Specifies the ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "boot_diagnostics" {
  description = "(Optional) Boot diagnostic block. Leaving 'enable' to true and 'storage_account_uri' empty will result in Managed Storage Account to store Boot Diagnostics. Default to disabled."
  type = object({
    enable              = bool
    storage_account_uri = optional(string, null)
  })
  default = {
    enable = false
  }
}

variable "enable_accelerated_networking" {
  description = "(Optional) Should Accelerated Networking be enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "nic_nsg_id" {
  description = "(Optional) The ID of the Network Security Group which should be attached to the Network Interface."
  type        = string
  default     = null
}

variable "attach_application_gateway" {
  description = "(Optional) A boolean to attach or not the virtual machine network interface to an application gateway. Default to 'false'."
  type        = bool
  default     = false
}

variable "attach_load_balancer" {
  description = "(Optional) A boolean to attach or not the virtual machine network interface to a load balancer. Default to 'false'."
  type        = bool
  default     = false
}

variable "application_gateway_backend_pool_id" {
  description = "(Optional) Backend pool ID of the application gateway. The variable 'attach_application_gateway' should be set to 'true'."
  type        = string
  default     = null
}

variable "load_balancer_backend_pool_id" {
  description = "(Optional) Backend pool ID of the load balancer. The variable 'attach_load_balancer' should be set to 'true'."
  type        = string
  default     = null
}

variable "data_disks" {
  description = "(Optional) Data disk map of objects to create and attach managed disks to the virtual machine."
  type = map(object({
    name                 = optional(string)
    create_option        = optional(string, "Empty")
    disk_size_gb         = number
    lun                  = optional(number)
    caching              = optional(string, "ReadWrite")
    storage_account_type = optional(string, "StandardSSD_LRS")
    source_resource_id   = optional(string)
    extra_tags           = optional(map(string), {})
  }))
  default = {}
}

variable "identity" {
  description = "(Optional) Configuration block in which you can specify the type of Managed Service Identity that should be configured on this Windows Virtual Machine. Default to value for type is ''SystemAssigned."
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = {
    type         = "SystemAssigned"
    identity_ids = []
  }
}

variable "public_ip_sku" {
  type    = string
  default = "Standard"
}

variable "public_ip_zones" {
  description = "(Optional) A collection containing the availability zone to allocate the Public IP in. Changing this forces a new resource to be created."
  type        = list(number)
  default     = [1, 2, 3]
}

variable "domain_dns_label" {
  description = "(Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
  type        = string
  default     = ""
}

variable "license_type" {
  description = "(Optional) Specifies the type of on-premise license (also known as Azure Hybrid Use Benefit) which should be used for this Virtual Machine. Possible values are None, Windows_Client and Windows_Server."
  type        = string
  default     = null
}

variable "os_disk_caching" {
  description = "(Optional) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite. Default to 'ReadWrite'."
  type        = string
  default     = "ReadWrite"
}

variable "os_disk_size_gb" {
  description = "(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
  type        = string
  default     = null
}

variable "os_disk_storage_account_type" {
  description = "(Optional) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created.Default to 'Standard_LRS'."
  type        = string
  default     = "Standard_LRS"
}


variable "source_image_id" {
  description = "(Optional) The ID of the Image which this Virtual Machine should be created from. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "static_private_ip" {
  description = "(Optional) The Static IP Address which should be used."
  type        = string
  default     = null
}

variable "timezone" {
  description = "(Optional) Specifies the Time Zone which should be used by the Virtual Machine."
  type        = string
  default     = null
}

variable "vm_image" {
  description = "(Optional) An equivalent of the 'source_image_reference' block."
  type        = map(string)
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

variable "vm_plan" {
  description = "(Optional) An equivalent of the 'plan' block."
  type = object({
    name      = string
    product   = string
    publisher = string
  })
  default = null
}

variable "zone_id" {
  description = "(Optional) Specifies the Availability Zone in which this Windows Virtual Machine should be located. Changing this forces a new Windows Virtual Machine to be created."
  type        = number
  default     = null
}

variable "enable_aad_login" {
  description = "(Optional) Enable Azure AD / Entra AD login on the virtual machine. Default to 'false'."
  type        = bool
  default     = false
}

variable "backup_policy_id" {
  description = "(Optional) Recovery Service Vault backup policy ID for the virtual machine."
  type        = string
  default     = null
}

variable "ad_settings" {
  description = "(Optional) Active Directory (ADDS) settings to join the virtual machine to a domain."
  type = object({
    domain   = string
    username = string
    password = string
    ou_path  = optional(string, "")
  })
  default = null
}

variable "vm_shutdown_schedule" {
  description = "(Optional) Virtual Machine shutdown schedule if needed."
  type = object({
    daily_recurrence_time = string
    timezone              = optional(string, "UTC")
    notifications = optional(object({
      email           = optional(string)
      time_in_minutes = optional(number)
      webhook_url     = optional(string)
    }))
  })
  default = null
}

variable "enable_module_tags" {
  description = "(Optional) Enable or not built-in mapping of tags which should be assigned to the Virtual Machine. Default to 'true'."
  type        = bool
  default     = true
}

variable "tags" {
  description = "(Optional) A mapping of tags which should be assigned to the Virtual Machine."
  type        = map(string)
  default     = {}
}


