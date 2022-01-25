provider "azurerm" {
   features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg"
  location = "West Europe"
}

resource "azurerm_storage_account" "stg" {
  name                     = "stg"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "dev"
  }
}

####################### Provisioning the azure kubernetes cluster #######################

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "myprefix"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw

  sensitive = true
}
###########################################################################################

########################### Provisioning Grafana Infrastructure ###########################

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet02"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "snet" {
  name                 = "snet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "pubip" {
  name                    = "pubip"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}

resource "azurerm_network_security_group" "secgr" {
  name                = "secgr"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
      name                       = "SSH"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface" "netint" {
  name                = "netint"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration2"
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.pubip.id}"

  }
}

resource "azurerm_virtual_machine" "vmname" {
  name                  = "vmname"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.netint.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

    storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.6"
    version   = "latest"
  }
  storage_os_disk {
    name                 = "vmosdisk2"
    caching              = "ReadWrite"
    create_option        = "FromImage"
    disk_size_gb         = "128"
    #storage_account_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "vmname"
    admin_username = "marcio"
    admin_password = "mudar@21"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "staging"
  }
}
###########################################################################################

