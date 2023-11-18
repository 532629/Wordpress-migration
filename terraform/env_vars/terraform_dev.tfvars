#Please provide the values from your Azure Admin
azure_subscription_id = ""
azure_client_id = ""
azure_tenant_id = ""

resource_group_name_prefix=dev_wp_rg
resource_group_location = "uksouth"
domain_name             = "azurequickstart.org"
computer_name           = "wp_dev"

 "tags" {
  type = map(string)
  default = {
    environment   = "dev"
  }
}
