variable "azure_subscription_id" {
  default=""
  description = "Azure Subscription ID"
}
variable "azure_client_id" {
  default=""
  description = "Azure Client ID"
}
variable "azure_client_secret" {
  default=""
  description = "Azure Client Secret"
}
variable "azure_tenant_id" {
  default=""
  description = "Azure Tenant ID"
}

variable "domain_name" {
  default = ""
}

variable "resource_group_location" {
  default     = ""
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = ""
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "tags" {
  type = map(string)
  default = {
    environment   = ""
    devopsowner   = "Ghanshyam"
    devopsproject = "wp"
  }
}

variable "computer_name" {
  default = ""
}

variable "username" {
  default = "wp"
}

# coma seperated string array of White list IPs
variable "whitelist_ips" {
    type = list(string)
    default = ["xxx.xxx.xxx.xxx/32","xxx.xxx.xxx.xxx"]
}
