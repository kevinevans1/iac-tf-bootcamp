#Azure Windows Virtual Machine Refrence#
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine#


#Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

#Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg_name
  depends_on          = [azurerm_resource_group.state-demo-secure]

}

#Virtual Network Subnet
resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on           = [azurerm_virtual_network.example]
}

#Network Security Group
resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = var.location
  resource_group_name = var.rg_name
  depends_on          = [azurerm_subnet.example]

  security_rule {
    name                       = "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "3389"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
 
  tags = {
    environment = "Dev"
  }
}

#Network Secuirty Group Association
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example.id
  depends_on                = [azurerm_network_security_group.example]
}

#Virtual Machine Public IP
resource "azurerm_public_ip" "public_ip" {
  name                = "vm_public_ip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Dynamic"
  depends_on = [
    azurerm_resource_group.state-demo-secure
  ]
}


#Windows Virtual Machine
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = var.location
  resource_group_name = var.rg_name
  depends_on          = [azurerm_resource_group.state-demo-secure,azurerm_subnet.example,azurerm_public_ip.public_ip]

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id

  }
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  depends_on          = [azurerm_network_interface.example,azurerm_resource_group.state-demo-secure]
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}