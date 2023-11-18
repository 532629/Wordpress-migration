# Generate random resource group name
resource "random_pet" "azure_rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "azure_rg" {
  location = var.resource_group_location
  name     = random_pet.azure_rg_name.id
  tags     = var.tags
}

# Azure domian Configuration
resource "azurerm_dns_zone" "cloud_dns_zone" {
  name                = "${var.computer_name}.${var.domain_name}"
  resource_group_name = azurerm_resource_group.azure_rg.name
  tags                = var.tags
}

resource "azurerm_dns_a_record" "wp_dns_record" {
  name                = "wp-url"
  zone_name           = azurerm_dns_zone.cloud_dns_zone.name
  resource_group_name = azurerm_resource_group.azure_rg.name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.azure_pip.id
}

resource "azurerm_virtual_network" "azure_vn" {
  name                = "azure_vn-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.azure_rg.location
  resource_group_name = azurerm_resource_group.azure_rg.name
  tags                = var.tags
}

resource "azurerm_subnet" "azure_subnet" {
  name                 = "azure_sub-subnet"
  resource_group_name  = azurerm_resource_group.azure_rg.name
  virtual_network_name = azurerm_virtual_network.azure_vn.name
  address_prefixes     = ["10.0.2.0/24"]
  
}


resource "azurerm_public_ip" "azure_pip" {
  name                = "wp-pip"
  location            = azurerm_resource_group.azure_rg.location
  resource_group_name = azurerm_resource_group.azure_rg.name
  allocation_method   = "Dynamic"
  ip_version          = "IPv4"
}



resource "azurerm_network_interface" "azure_ni" {
  name                = "azure_ni-nic"
  location            = azurerm_resource_group.azure_rg.location
  resource_group_name = azurerm_resource_group.azure_rg.name
  tags                = var.tags

  ip_configuration {
    name                          = "wp_nic_configuration"
    subnet_id                     = azurerm_subnet.azure_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id           = azurerm_public_ip.azure_pip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "wp-NI-NSG" {
  network_interface_id      = azurerm_network_interface.azure_ni.id
  network_security_group_id = azurerm_network_security_group.wp_prod_nsg.id
}

resource "azurerm_linux_virtual_machine" "wp-vm" {
  name                  = var.computer_name
  location              = azurerm_resource_group.azure_rg.location
  resource_group_name   = azurerm_resource_group.azure_rg.name
  network_interface_ids = [azurerm_network_interface.azure_ni.id]
  tags                = var.tags

  os_disk {
    name                 = "wp-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  size = "Standard_D2S_v3"
  admin_username = var.username
  

  admin_ssh_key {
    username   = var.username
    public_key = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
  }


}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "wp-nsg" {
  name                = "wp-NGS"
  location            = azurerm_resource_group.azure_rg.location
  resource_group_name = azurerm_resource_group.azure_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 301
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefixes      = var.whitelist_ips
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "HTTPS"
    priority                   = 302
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefixes    =  var.whitelist_ips
    destination_address_prefix = "*"
  }
}

/*
resource "azurerm_dev_test_global_vm_shutdown_schedule" "azure_shutdown" {
  virtual_machine_id      = azurerm_linux_virtual_machine.wp-vm.id
  location                = azurerm_resource_group.azure_rg.location
  enabled                 = true
  daily_recurrence_time    = "1800"  # 6 PM in UK time
  timezone                = "GMT Standard Time"

  notification_settings {
    enabled         = true
    time_in_minutes = "60"
    email     = "ghanshyam.gupta.it@gmail.com"
  }
}
*/

