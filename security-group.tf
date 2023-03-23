#NSG VM LINUX
resource "azurerm_network_security_group" "nsg_lab01" {
  name                = "nsg_lab01"
  location            = var.azure_region
  resource_group_name = var.azure_rg

  security_rule {
    name                       = "liberaportasshlab01"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "191.183.38.213"
    destination_address_prefix = "10.1.2.4"
  }

  tags = {
    environment = "PRD"
  }
}

resource "azurerm_network_interface_security_group_association" "nsgasso_lab01" {
  network_interface_id      = azurerm_network_interface.nic_lab01.id
  network_security_group_id = azurerm_network_security_group.nsg_lab01.id
}

#NSG VM WINDOWS
resource "azurerm_network_security_group" "nsg_2_lab01" {
  name                = "nsg_2_lab01"
  location            = var.azure_region
  resource_group_name = var.azure_rg

  security_rule {
    name                       = "liberaportardplab01"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "191.183.38.213"
    destination_address_prefix = "10.1.2.5"
  }

  tags = {
    environment = "PRD"
  }
}

resource "azurerm_network_interface_security_group_association" "nsgasso_lab02" {
  network_interface_id      = azurerm_network_interface.nic_2_lab01.id
  network_security_group_id = azurerm_network_security_group.nsg_2_lab01.id
}