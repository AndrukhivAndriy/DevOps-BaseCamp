
 resource "azurerm_resource_group" "Grafanamain" {
  name     = "Main_res_group_for_server_grafana"
  location = var.res_group_location
}
 
 # Azure virtual network
resource "azurerm_virtual_network" "VM_network_grafana" {
  name                = "Virtual_network_for_Grafana"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Grafanamain.location
  resource_group_name = azurerm_resource_group.Grafanamain.name
  
}
resource "azurerm_subnet" "subnet_a" {
  name                 = "create_subnet_a"
  resource_group_name  = azurerm_resource_group.Grafanamain.name
  virtual_network_name = azurerm_virtual_network.VM_network_grafana.name
  address_prefixes     = ["10.0.11.0/24"]
}
resource "azurerm_network_security_group" "net_sec_group" {
  name                = "network_sec_group_for_grafana"
  location            = azurerm_resource_group.Grafanamain.location
  resource_group_name = azurerm_resource_group.Grafanamain.name

  security_rule {
    name                       = "Allow_httpd"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow_Grafana"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow_ssh"
    priority                   = 202
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.subnet_a.id
  network_security_group_id = azurerm_network_security_group.net_sec_group.id
}
# Azurerm public ip
resource "azurerm_public_ip" "grafana_public_ip" {
  name                = "Grafana_IP"
  location            = azurerm_resource_group.Grafanamain.location
  resource_group_name = azurerm_resource_group.Grafanamain.name
  allocation_method   = "Static"
}
# Azurerm network interface
resource "azurerm_network_interface" "Grafana_net_int" {
  name                = "Grafana_network_interface"
  location            = azurerm_resource_group.Grafanamain.location
  resource_group_name = azurerm_resource_group.Grafanamain.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_a.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.grafana_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "VM-TR" {
  name                = "GrafanaInstance"
  computer_name       = "AndrukhivComp"
  resource_group_name = azurerm_resource_group.Grafanamain.name
  location            = azurerm_resource_group.Grafanamain.location
  size                = var.size
  admin_username      = "ec2-user"
  custom_data         = filebase64("userdata/azureuserdata.sh")
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.Grafana_net_int.id,
  ]

admin_ssh_key {
   username   = "ec2-user"
   public_key = file(var.public_key)
  }

  os_disk {
    name                 = "grafana-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = "7_8-gen2"
    version   = "latest" 
  }
}

