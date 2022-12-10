# Load Balancer in Azure with 2 VM

Public IP of Load Balancer : 20.42.129.255

Just in case, 2 VM have public IPs (4.227.187.50, 20.51.208.117). 

Load Balancer in browser:

<img src="https://user-images.githubusercontent.com/79985930/206830606-b2e4f0ab-4c2a-474b-adc4-518de10c71d3.png" width="450" height="120" />

And one more time...

<img src="https://user-images.githubusercontent.com/79985930/206830641-3345fbc3-3a47-43e0-95d2-b796c25a82f0.png" width="450" height="120" />

## Resource template

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "virtualMachines_vm1_name": {
            "defaultValue": "vm1",
            "type": "String"
        },
        "virtualMachines_vm2_name": {
            "defaultValue": "vm2",
            "type": "String"
        },
        "sshPublicKeys_vm1_key_name": {
            "defaultValue": "vm1_key",
            "type": "String"
        },
        "publicIPAddresses_vm1_ip_name": {
            "defaultValue": "vm1-ip",
            "type": "String"
        },
        "publicIPAddresses_vm2_ip_name": {
            "defaultValue": "vm2-ip",
            "type": "String"
        },
        "publicIPAddresses_pubIPLB_name": {
            "defaultValue": "pubIPLB",
            "type": "String"
        },
        "loadBalancers_DevopsCampRG_name": {
            "defaultValue": "DevopsCampRG",
            "type": "String"
        },
        "networkInterfaces_vm1396_z1_name": {
            "defaultValue": "vm1396_z1",
            "type": "String"
        },
        "networkInterfaces_vm2712_z2_name": {
            "defaultValue": "vm2712_z2",
            "type": "String"
        },
        "virtualNetworks_DevopsCampVN_name": {
            "defaultValue": "DevopsCampVN",
            "type": "String"
        },
        "networkSecurityGroups_vm1_nsg_name": {
            "defaultValue": "vm1-nsg",
            "type": "String"
        },
        "networkSecurityGroups_vm2_nsg_name": {
            "defaultValue": "vm2-nsg",
            "type": "String"
        },
        "networkSecurityGroups_vm1nsg468_name": {
            "defaultValue": "vm1nsg468",
            "type": "String"
        }
    },
    "variables": {},
    "resources": [
        {
            "type": "Microsoft.Compute/sshPublicKeys",
            "apiVersion": "2022-08-01",
            "name": "[parameters('sshPublicKeys_vm1_key_name')]",
            "location": "eastus",
            "properties": {
                "publicKey": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgH+RKWhq3IoA+QMcsvTQjoqev+0zKVgHbRpbwhoZ0wdF41rMvZyOLtZ9kE5i20L+ho8Iv3JLkJoqb1cMsCDiQyHl/UHblj4ZvBB5g808l3+YykoE6F8zir0MUfbKjzCL5+6AbnL06fBlWINMCDff8syGmo+6mXlgjS0lRAdK1RhP1Qd70nkm0PKpgI6T+lokkBoDefMfTCIelev/B3rwFQOGZGoCF8KIh97O/oq0UaNAZjTRvLFuWVhFg0L2y9RF9GPoh+T8MYVjszYvAmWkk9NVJavUqVBXduvSi0THjVf7HZiIlvBOq5S4FjQEa69WuLGctCC6R48nXFG11BuUuDzvJP2kc0DBZ+z0hxMJhniPfi8SNewN34jPu5bW1EtPfv7aCeSTg+VCyWEGn+69XQU0Uk356RArAGFi8ciVqRW8A5U/DmHRK/epB27Fpb0eo2wqD/TFhEQ8qzGI4y0X6rzLyrUWTMEMzNJy3kUnJF0p6TyH5XOKlB0ND8KJ3ik0= generated-by-azure"
            }
        },
        {
            "type": "Microsoft.Network/publicIPAddresses",
            "apiVersion": "2022-05-01",
            "name": "[parameters('publicIPAddresses_pubIPLB_name')]",
            "location": "eastus",
            "sku": {
                "name": "Standard",
                "tier": "Regional"
            },
            "zones": [
                "2",
                "1",
                "3"
            ],
            "properties": {
                "ipAddress": "20.242.129.255",
                "publicIPAddressVersion": "IPv4",
                "publicIPAllocationMethod": "Static",
                "idleTimeoutInMinutes": 4,
                "ipTags": []
            }
        },
        {
            "type": "Microsoft.Network/publicIPAddresses",
            "apiVersion": "2022-05-01",
            "name": "[parameters('publicIPAddresses_vm1_ip_name')]",
            "location": "eastus",
            "sku": {
                "name": "Standard",
                "tier": "Regional"
            },
            "zones": [
                "1"
            ],
            "properties": {
                "ipAddress": "4.227.187.50",
                "publicIPAddressVersion": "IPv4",
                "publicIPAllocationMethod": "Static",
                "idleTimeoutInMinutes": 4,
                "ipTags": []
            }
        },
        {
            "type": "Microsoft.Network/publicIPAddresses",
            "apiVersion": "2022-05-01",
            "name": "[parameters('publicIPAddresses_vm2_ip_name')]",
            "location": "eastus",
            "sku": {
                "name": "Standard",
                "tier": "Regional"
            },
            "zones": [
                "2"
            ],
            "properties": {
                "ipAddress": "20.51.208.117",
                "publicIPAddressVersion": "IPv4",
                "publicIPAllocationMethod": "Static",
                "idleTimeoutInMinutes": 4,
                "ipTags": []
            }
        },
        {
            "type": "Microsoft.Compute/virtualMachines",
            "apiVersion": "2022-08-01",
            "name": "[parameters('virtualMachines_vm1_name')]",
            "location": "eastus",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkInterfaces', parameters('networkInterfaces_vm1396_z1_name'))]"
            ],
            "zones": [
                "1"
            ],
            "properties": {
                "hardwareProfile": {
                    "vmSize": "Standard_B1s"
                },
                "storageProfile": {
                    "imageReference": {
                        "publisher": "canonical",
                        "offer": "0001-com-ubuntu-server-focal",
                        "sku": "20_04-lts-gen2",
                        "version": "latest"
                    },
                    "osDisk": {
                        "osType": "Linux",
                        "name": "[concat(parameters('virtualMachines_vm1_name'), '_OsDisk_1_19dc3e0d10384343a2aec455f9d95efd')]",
                        "createOption": "FromImage",
                        "caching": "ReadWrite",
                        "managedDisk": {
                            "storageAccountType": "StandardSSD_LRS",
                            "id": "[resourceId('Microsoft.Compute/disks', concat(parameters('virtualMachines_vm1_name'), '_OsDisk_1_19dc3e0d10384343a2aec455f9d95efd'))]"
                        },
                        "deleteOption": "Delete",
                        "diskSizeGB": 30
                    },
                    "dataDisks": []
                },
                "osProfile": {
                    "computerName": "[parameters('virtualMachines_vm1_name')]",
                    "adminUsername": "azureuser",
                    "linuxConfiguration": {
                        "disablePasswordAuthentication": true,
                        "ssh": {
                            "publicKeys": [
                                {
                                    "path": "/home/azureuser/.ssh/authorized_keys",
                                    "keyData": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgH+RKWhq3IoA+QMcsvTQjoqev+0zKVgHbRpbwhoZ0wdF41rMvZyOLtZ9kE5i20L+ho8Iv3JLkJoqb1cMsCDiQyHl/UHblj4ZvBB5g808l3+YykoE6F8zir0MUfbKjzCL5+6AbnL06fBlWINMCDff8syGmo+6mXlgjS0lRAdK1RhP1Qd70nkm0PKpgI6T+lokkBoDefMfTCIelev/B3rwFQOGZGoCF8KIh97O/oq0UaNAZjTRvLFuWVhFg0L2y9RF9GPoh+T8MYVjszYvAmWkk9NVJavUqVBXduvSi0THjVf7HZiIlvBOq5S4FjQEa69WuLGctCC6R48nXFG11BuUuDzvJP2kc0DBZ+z0hxMJhniPfi8SNewN34jPu5bW1EtPfv7aCeSTg+VCyWEGn+69XQU0Uk356RArAGFi8ciVqRW8A5U/DmHRK/epB27Fpb0eo2wqD/TFhEQ8qzGI4y0X6rzLyrUWTMEMzNJy3kUnJF0p6TyH5XOKlB0ND8KJ3ik0= generated-by-azure"
                                }
                            ]
                        },
                        "provisionVMAgent": true,
                        "patchSettings": {
                            "patchMode": "ImageDefault",
                            "assessmentMode": "ImageDefault"
                        },
                        "enableVMAgentPlatformUpdates": false
                    },
                    "secrets": [],
                    "allowExtensionOperations": true,
                    "requireGuestProvisionSignal": true
                },
                "networkProfile": {
                    "networkInterfaces": [
                        {
                            "id": "[resourceId('Microsoft.Network/networkInterfaces', parameters('networkInterfaces_vm1396_z1_name'))]",
                            "properties": {
                                "deleteOption": "Delete"
                            }
                        }
                    ]
                },
                "diagnosticsProfile": {
                    "bootDiagnostics": {
                        "enabled": true
                    }
                }
            }
        },
        {
            "type": "Microsoft.Compute/virtualMachines",
            "apiVersion": "2022-08-01",
            "name": "[parameters('virtualMachines_vm2_name')]",
            "location": "eastus",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkInterfaces', parameters('networkInterfaces_vm2712_z2_name'))]"
            ],
            "zones": [
                "2"
            ],
            "properties": {
                "hardwareProfile": {
                    "vmSize": "Standard_B1s"
                },
                "storageProfile": {
                    "imageReference": {
                        "publisher": "canonical",
                        "offer": "0001-com-ubuntu-server-focal",
                        "sku": "20_04-lts-gen2",
                        "version": "latest"
                    },
                    "osDisk": {
                        "osType": "Linux",
                        "name": "[concat(parameters('virtualMachines_vm2_name'), '_OsDisk_1_8727313d018e4773a16643685d94732b')]",
                        "createOption": "FromImage",
                        "caching": "ReadWrite",
                        "managedDisk": {
                            "storageAccountType": "StandardSSD_LRS",
                            "id": "[resourceId('Microsoft.Compute/disks', concat(parameters('virtualMachines_vm2_name'), '_OsDisk_1_8727313d018e4773a16643685d94732b'))]"
                        },
                        "deleteOption": "Delete",
                        "diskSizeGB": 30
                    },
                    "dataDisks": []
                },
                "osProfile": {
                    "computerName": "[parameters('virtualMachines_vm2_name')]",
                    "adminUsername": "azureuser",
                    "linuxConfiguration": {
                        "disablePasswordAuthentication": true,
                        "ssh": {
                            "publicKeys": [
                                {
                                    "path": "/home/azureuser/.ssh/authorized_keys",
                                    "keyData": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgH+RKWhq3IoA+QMcsvTQjoqev+0zKVgHbRpbwhoZ0wdF41rMvZyOLtZ9kE5i20L+ho8Iv3JLkJoqb1cMsCDiQyHl/UHblj4ZvBB5g808l3+YykoE6F8zir0MUfbKjzCL5+6AbnL06fBlWINMCDff8syGmo+6mXlgjS0lRAdK1RhP1Qd70nkm0PKpgI6T+lokkBoDefMfTCIelev/B3rwFQOGZGoCF8KIh97O/oq0UaNAZjTRvLFuWVhFg0L2y9RF9GPoh+T8MYVjszYvAmWkk9NVJavUqVBXduvSi0THjVf7HZiIlvBOq5S4FjQEa69WuLGctCC6R48nXFG11BuUuDzvJP2kc0DBZ+z0hxMJhniPfi8SNewN34jPu5bW1EtPfv7aCeSTg+VCyWEGn+69XQU0Uk356RArAGFi8ciVqRW8A5U/DmHRK/epB27Fpb0eo2wqD/TFhEQ8qzGI4y0X6rzLyrUWTMEMzNJy3kUnJF0p6TyH5XOKlB0ND8KJ3ik0= generated-by-azure"
                                }
                            ]
                        },
                        "provisionVMAgent": true,
                        "patchSettings": {
                            "patchMode": "ImageDefault",
                            "assessmentMode": "ImageDefault"
                        },
                        "enableVMAgentPlatformUpdates": false
                    },
                    "secrets": [],
                    "allowExtensionOperations": true,
                    "requireGuestProvisionSignal": true
                },
                "networkProfile": {
                    "networkInterfaces": [
                        {
                            "id": "[resourceId('Microsoft.Network/networkInterfaces', parameters('networkInterfaces_vm2712_z2_name'))]",
                            "properties": {
                                "deleteOption": "Delete"
                            }
                        }
                    ]
                },
                "diagnosticsProfile": {
                    "bootDiagnostics": {
                        "enabled": true
                    }
                }
            }
        },
        {
            "type": "Microsoft.Network/loadBalancers/backendAddressPools",
            "apiVersion": "2022-05-01",
            "name": "[concat(parameters('loadBalancers_DevopsCampRG_name'), '/backendpool')]",
            "dependsOn": [
                "[resourceId('Microsoft.Network/loadBalancers', parameters('loadBalancers_DevopsCampRG_name'))]"
            ],
            "properties": {
                "loadBalancerBackendAddresses": [
                    {
                        "name": "DevopsCampRG_vm1396_z1ipconfig1",
                        "properties": {}
                    },
                    {
                        "name": "DevopsCampRG_vm2712_z2ipconfig1",
                        "properties": {}
                    }
                ]
            }
        },
        {
            "type": "Microsoft.Network/networkSecurityGroups/securityRules",
            "apiVersion": "2022-05-01",
            "name": "[concat(parameters('networkSecurityGroups_vm1_nsg_name'), '/HTTP')]",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroups_vm1_nsg_name'))]"
            ],
            "properties": {
                "protocol": "TCP",
                "sourcePortRange": "*",
                "destinationPortRange": "80",
                "sourceAddressPrefix": "*",
                "destinationAddressPrefix": "*",
                "access": "Allow",
                "priority": 320,
                "direction": "Inbound",
                "sourcePortRanges": [],
                "destinationPortRanges": [],
                "sourceAddressPrefixes": [],
                "destinationAddressPrefixes": []
            }
        },
        {
            "type": "Microsoft.Network/networkSecurityGroups/securityRules",
            "apiVersion": "2022-05-01",
            "name": "[concat(parameters('networkSecurityGroups_vm1nsg468_name'), '/HTTP')]",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroups_vm1nsg468_name'))]"
            ],
            "properties": {
                "protocol": "TCP",
                "sourcePortRange": "*",
                "destinationPortRange": "80",
                "sourceAddressPrefix": "*",
                "destinationAddressPrefix": "*",
                "access": "Allow",
                "priority": 320,
                "direction": "Inbound",
                "sourcePortRanges": [],
                "destinationPortRanges": [],
                "sourceAddressPrefixes": [],
                "destinationAddressPrefixes": []
            }
        },
        {
            "type": "Microsoft.Network/networkSecurityGroups/securityRules",
            "apiVersion": "2022-05-01",
            "name": "[concat(parameters('networkSecurityGroups_vm2_nsg_name'), '/HTTP')]",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroups_vm2_nsg_name'))]"
            ],
            "properties": {
                "protocol": "TCP",
                "sourcePortRange": "*",
                "destinationPortRange": "80",
                "sourceAddressPrefix": "*",
                "destinationAddressPrefix": "*",
                "access": "Allow",
                "priority": 320,
                "direction": "Inbound",
                "sourcePortRanges": [],
                "destinationPortRanges": [],
                "sourceAddressPrefixes": [],
                "destinationAddressPrefixes": []
            }
        },
        {
            "type": "Microsoft.Network/networkSecurityGroups/securityRules",
            "apiVersion": "2022-05-01",
            "name": "[concat(parameters('networkSecurityGroups_vm1_nsg_name'), '/SSH')]",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroups_vm1_nsg_name'))]"
            ],
            "properties": {
                "protocol": "TCP",
                "sourcePortRange": "*",
                "destinationPortRange": "22",
                "sourceAddressPrefix": "*",
                "destinationAddressPrefix": "*",
                "access": "Allow",
                "priority": 300,
                "direction": "Inbound",
                "sourcePortRanges": [],
                "destinationPortRanges": [],
                "sourceAddressPrefixes": [],
                "destinationAddressPrefixes": []
            }
        },
        {
            "type": "Microsoft.Network/networkSecurityGroups/securityRules",
            "apiVersion": "2022-05-01",
            "name": "[concat(parameters('networkSecurityGroups_vm1nsg468_name'), '/SSH')]",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroups_vm1nsg468_name'))]"
            ],
            "properties": {
                "protocol": "TCP",
                "sourcePortRange": "*",
                "destinationPortRange": "22",
                "sourceAddressPrefix": "*",
                "destinationAddressPrefix": "*",
                "access": "Allow",
                "priority": 300,
                "direction": "Inbound",
                "sourcePortRanges": [],
                "destinationPortRanges": [],
                "sourceAddressPrefixes": [],
                "destinationAddressPrefixes": []
            }
        },
        {
            "type": "Microsoft.Network/networkSecurityGroups/securityRules",
            "apiVersion": "2022-05-01",
            "name": "[concat(parameters('networkSecurityGroups_vm2_nsg_name'), '/SSH')]",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroups_vm2_nsg_name'))]"
            ],
            "properties": {
                "protocol": "TCP",
                "sourcePortRange": "*",
                "destinationPortRange": "22",
                "sourceAddressPrefix": "*",
                "destinationAddressPrefix": "*",
                "access": "Allow",
                "priority": 300,
                "direction": "Inbound",
                "sourcePortRanges": [],
                "destinationPortRanges": [],
                "sourceAddressPrefixes": [],
                "destinationAddressPrefixes": []
            }
        },
        {
            "type": "Microsoft.Network/virtualNetworks",
            "apiVersion": "2022-05-01",
            "name": "[parameters('virtualNetworks_DevopsCampVN_name')]",
            "location": "eastus",
            "dependsOn": [
                "[resourceId('Microsoft.Network/virtualNetworks/subnets', parameters('virtualNetworks_DevopsCampVN_name'), 'DevopsCampSubnet')]"
            ],
            "properties": {
                "addressSpace": {
                    "addressPrefixes": [
                        "10.0.0.0/16"
                    ]
                },
                "subnets": [
                    {
                        "name": "DevopsCampSubnet",
                        "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', parameters('virtualNetworks_DevopsCampVN_name'), 'DevopsCampSubnet')]",
                        "properties": {
                            "addressPrefix": "10.0.0.0/24",
                            "delegations": [],
                            "privateEndpointNetworkPolicies": "Disabled",
                            "privateLinkServiceNetworkPolicies": "Enabled"
                        },
                        "type": "Microsoft.Network/virtualNetworks/subnets"
                    }
                ],
                "virtualNetworkPeerings": [],
                "enableDdosProtection": false
            }
        },
        {
            "type": "Microsoft.Network/virtualNetworks/subnets",
            "apiVersion": "2022-05-01",
            "name": "[concat(parameters('virtualNetworks_DevopsCampVN_name'), '/DevopsCampSubnet')]",
            "dependsOn": [
                "[resourceId('Microsoft.Network/virtualNetworks', parameters('virtualNetworks_DevopsCampVN_name'))]"
            ],
            "properties": {
                "addressPrefix": "10.0.0.0/24",
                "delegations": [],
                "privateEndpointNetworkPolicies": "Disabled",
                "privateLinkServiceNetworkPolicies": "Enabled"
            }
        },
        {
            "type": "Microsoft.Network/loadBalancers",
            "apiVersion": "2022-05-01",
            "name": "[parameters('loadBalancers_DevopsCampRG_name')]",
            "location": "eastus",
            "dependsOn": [
                "[resourceId('Microsoft.Network/publicIPAddresses', parameters('publicIPAddresses_pubIPLB_name'))]",
                "[resourceId('Microsoft.Network/loadBalancers/backendAddressPools', parameters('loadBalancers_DevopsCampRG_name'), 'backendpool')]"
            ],
            "sku": {
                "name": "Standard",
                "tier": "Regional"
            },
            "properties": {
                "frontendIPConfigurations": [
                    {
                        "name": "frontipLB",
                        "id": "[concat(resourceId('Microsoft.Network/loadBalancers', parameters('loadBalancers_DevopsCampRG_name')), '/frontendIPConfigurations/frontipLB')]",
                        "properties": {
                            "privateIPAllocationMethod": "Dynamic",
                            "publicIPAddress": {
                                "id": "[resourceId('Microsoft.Network/publicIPAddresses', parameters('publicIPAddresses_pubIPLB_name'))]"
                            }
                        }
                    }
                ],
                "backendAddressPools": [
                    {
                        "name": "backendpool",
                        "id": "[resourceId('Microsoft.Network/loadBalancers/backendAddressPools', parameters('loadBalancers_DevopsCampRG_name'), 'backendpool')]",
                        "properties": {
                            "loadBalancerBackendAddresses": [
                                {
                                    "name": "[concat(parameters('loadBalancers_DevopsCampRG_name'), '_vm1396_z1ipconfig1')]",
                                    "properties": {}
                                },
                                {
                                    "name": "[concat(parameters('loadBalancers_DevopsCampRG_name'), '_vm2712_z2ipconfig1')]",
                                    "properties": {}
                                }
                            ]
                        }
                    }
                ],
                "loadBalancingRules": [
                    {
                        "name": "LoadBalrule",
                        "id": "[concat(resourceId('Microsoft.Network/loadBalancers', parameters('loadBalancers_DevopsCampRG_name')), '/loadBalancingRules/LoadBalrule')]",
                        "properties": {
                            "frontendIPConfiguration": {
                                "id": "[concat(resourceId('Microsoft.Network/loadBalancers', parameters('loadBalancers_DevopsCampRG_name')), '/frontendIPConfigurations/frontipLB')]"
                            },
                            "frontendPort": 80,
                            "backendPort": 80,
                            "enableFloatingIP": false,
                            "idleTimeoutInMinutes": 4,
                            "protocol": "Tcp",
                            "enableTcpReset": false,
                            "loadDistribution": "Default",
                            "disableOutboundSnat": true,
                            "backendAddressPool": {
                                "id": "[resourceId('Microsoft.Network/loadBalancers/backendAddressPools', parameters('loadBalancers_DevopsCampRG_name'), 'backendpool')]"
                            },
                            "backendAddressPools": [
                                {
                                    "id": "[resourceId('Microsoft.Network/loadBalancers/backendAddressPools', parameters('loadBalancers_DevopsCampRG_name'), 'backendpool')]"
                                }
                            ],
                            "probe": {
                                "id": "[concat(resourceId('Microsoft.Network/loadBalancers', parameters('loadBalancers_DevopsCampRG_name')), '/probes/Healthprobe')]"
                            }
                        }
                    }
                ],
                "probes": [
                    {
                        "name": "Healthprobe",
                        "id": "[concat(resourceId('Microsoft.Network/loadBalancers', parameters('loadBalancers_DevopsCampRG_name')), '/probes/Healthprobe')]",
                        "properties": {
                            "protocol": "Http",
                            "port": 80,
                            "requestPath": "/",
                            "intervalInSeconds": 15,
                            "numberOfProbes": 1,
                            "probeThreshold": 1
                        }
                    }
                ],
                "inboundNatRules": [],
                "outboundRules": [],
                "inboundNatPools": []
            }
        },
        {
            "type": "Microsoft.Network/networkSecurityGroups",
            "apiVersion": "2022-05-01",
            "name": "[parameters('networkSecurityGroups_vm1_nsg_name')]",
            "location": "eastus",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkSecurityGroups/securityRules', parameters('networkSecurityGroups_vm1_nsg_name'), 'SSH')]",
                "[resourceId('Microsoft.Network/networkSecurityGroups/securityRules', parameters('networkSecurityGroups_vm1_nsg_name'), 'HTTP')]"
            ],
            "properties": {
                "securityRules": [
                    {
                        "name": "SSH",
                        "id": "[resourceId('Microsoft.Network/networkSecurityGroups/securityRules', parameters('networkSecurityGroups_vm1_nsg_name'), 'SSH')]",
                        "type": "Microsoft.Network/networkSecurityGroups/securityRules",
                        "properties": {
                            "protocol": "TCP",
                            "sourcePortRange": "*",
                            "destinationPortRange": "22",
                            "sourceAddressPrefix": "*",
                            "destinationAddressPrefix": "*",
                            "access": "Allow",
                            "priority": 300,
                            "direction": "Inbound",
                            "sourcePortRanges": [],
                            "destinationPortRanges": [],
                            "sourceAddressPrefixes": [],
                            "destinationAddressPrefixes": []
                        }
                    },
                    {
                        "name": "HTTP",
                        "id": "[resourceId('Microsoft.Network/networkSecurityGroups/securityRules', parameters('networkSecurityGroups_vm1_nsg_name'), 'HTTP')]",
                        "type": "Microsoft.Network/networkSecurityGroups/securityRules",
                        "properties": {
                            "protocol": "TCP",
                            "sourcePortRange": "*",
                            "destinationPortRange": "80",
                            "sourceAddressPrefix": "*",
                            "destinationAddressPrefix": "*",
                            "access": "Allow",
                            "priority": 320,
                            "direction": "Inbound",
                            "sourcePortRanges": [],
                            "destinationPortRanges": [],
                            "sourceAddressPrefixes": [],
                            "destinationAddressPrefixes": []
                        }
                    }
                ]
            }
        },
        {
            "type": "Microsoft.Network/networkSecurityGroups",
            "apiVersion": "2022-05-01",
            "name": "[parameters('networkSecurityGroups_vm1nsg468_name')]",
            "location": "eastus",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkSecurityGroups/securityRules', parameters('networkSecurityGroups_vm1nsg468_name'), 'SSH')]",
                "[resourceId('Microsoft.Network/networkSecurityGroups/securityRules', parameters('networkSecurityGroups_vm1nsg468_name'), 'HTTP')]"
            ],
            "properties": {
                "securityRules": [
                    {
                        "name": "SSH",
                        "id": "[resourceId('Microsoft.Network/networkSecurityGroups/securityRules', parameters('networkSecurityGroups_vm1nsg468_name'), 'SSH')]",
                        "type": "Microsoft.Network/networkSecurityGroups/securityRules",
                        "properties": {
                            "protocol": "TCP",
                            "sourcePortRange": "*",
                            "destinationPortRange": "22",
                            "sourceAddressPrefix": "*",
                            "destinationAddressPrefix": "*",
                            "access": "Allow",
                            "priority": 300,
                            "direction": "Inbound",
                            "sourcePortRanges": [],
                            "destinationPortRanges": [],
                            "sourceAddressPrefixes": [],
                            "destinationAddressPrefixes": []
                        }
                    },
                    {
                        "name": "HTTP",
                        "id": "[resourceId('Microsoft.Network/networkSecurityGroups/securityRules', parameters('networkSecurityGroups_vm1nsg468_name'), 'HTTP')]",
                        "type": "Microsoft.Network/networkSecurityGroups/securityRules",
                        "properties": {
                            "protocol": "TCP",
                            "sourcePortRange": "*",
                            "destinationPortRange": "80",
                            "sourceAddressPrefix": "*",
                            "destinationAddressPrefix": "*",
                            "access": "Allow",
                            "priority": 320,
                            "direction": "Inbound",
                            "sourcePortRanges": [],
                            "destinationPortRanges": [],
                            "sourceAddressPrefixes": [],
                            "destinationAddressPrefixes": []
                        }
                    }
                ]
            }
        },
        {
            "type": "Microsoft.Network/networkSecurityGroups",
            "apiVersion": "2022-05-01",
            "name": "[parameters('networkSecurityGroups_vm2_nsg_name')]",
            "location": "eastus",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkSecurityGroups/securityRules', parameters('networkSecurityGroups_vm2_nsg_name'), 'SSH')]",
                "[resourceId('Microsoft.Network/networkSecurityGroups/securityRules', parameters('networkSecurityGroups_vm2_nsg_name'), 'HTTP')]"
            ],
            "properties": {
                "securityRules": [
                    {
                        "name": "SSH",
                        "id": "[resourceId('Microsoft.Network/networkSecurityGroups/securityRules', parameters('networkSecurityGroups_vm2_nsg_name'), 'SSH')]",
                        "type": "Microsoft.Network/networkSecurityGroups/securityRules",
                        "properties": {
                            "protocol": "TCP",
                            "sourcePortRange": "*",
                            "destinationPortRange": "22",
                            "sourceAddressPrefix": "*",
                            "destinationAddressPrefix": "*",
                            "access": "Allow",
                            "priority": 300,
                            "direction": "Inbound",
                            "sourcePortRanges": [],
                            "destinationPortRanges": [],
                            "sourceAddressPrefixes": [],
                            "destinationAddressPrefixes": []
                        }
                    },
                    {
                        "name": "HTTP",
                        "id": "[resourceId('Microsoft.Network/networkSecurityGroups/securityRules', parameters('networkSecurityGroups_vm2_nsg_name'), 'HTTP')]",
                        "type": "Microsoft.Network/networkSecurityGroups/securityRules",
                        "properties": {
                            "protocol": "TCP",
                            "sourcePortRange": "*",
                            "destinationPortRange": "80",
                            "sourceAddressPrefix": "*",
                            "destinationAddressPrefix": "*",
                            "access": "Allow",
                            "priority": 320,
                            "direction": "Inbound",
                            "sourcePortRanges": [],
                            "destinationPortRanges": [],
                            "sourceAddressPrefixes": [],
                            "destinationAddressPrefixes": []
                        }
                    }
                ]
            }
        },
        {
            "type": "Microsoft.Network/networkInterfaces",
            "apiVersion": "2022-05-01",
            "name": "[parameters('networkInterfaces_vm1396_z1_name')]",
            "location": "eastus",
            "dependsOn": [
                "[resourceId('Microsoft.Network/publicIPAddresses', parameters('publicIPAddresses_vm1_ip_name'))]",
                "[resourceId('Microsoft.Network/virtualNetworks/subnets', parameters('virtualNetworks_DevopsCampVN_name'), 'DevopsCampSubnet')]",
                "[resourceId('Microsoft.Network/loadBalancers/backendAddressPools', parameters('loadBalancers_DevopsCampRG_name'), 'backendpool')]",
                "[resourceId('Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroups_vm1nsg468_name'))]"
            ],
            "kind": "Regular",
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipconfig1",
                        "id": "[concat(resourceId('Microsoft.Network/networkInterfaces', parameters('networkInterfaces_vm1396_z1_name')), '/ipConfigurations/ipconfig1')]",
                        "etag": "W/\"964547f2-f1cc-48d8-a392-9ef3bc810cd7\"",
                        "type": "Microsoft.Network/networkInterfaces/ipConfigurations",
                        "properties": {
                            "provisioningState": "Succeeded",
                            "privateIPAddress": "10.0.0.4",
                            "privateIPAllocationMethod": "Dynamic",
                            "publicIPAddress": {
                                "name": "vm1-ip",
                                "id": "[resourceId('Microsoft.Network/publicIPAddresses', parameters('publicIPAddresses_vm1_ip_name'))]",
                                "properties": {
                                    "provisioningState": "Succeeded",
                                    "resourceGuid": "7b4f61f8-48d0-4c8b-a516-c8460d2e1e29",
                                    "publicIPAddressVersion": "IPv4",
                                    "publicIPAllocationMethod": "Dynamic",
                                    "idleTimeoutInMinutes": 4,
                                    "ipTags": [],
                                    "ipConfiguration": {
                                        "id": "[concat(resourceId('Microsoft.Network/networkInterfaces', parameters('networkInterfaces_vm1396_z1_name')), '/ipConfigurations/ipconfig1')]"
                                    },
                                    "deleteOption": "Delete"
                                },
                                "type": "Microsoft.Network/publicIPAddresses",
                                "sku": {
                                    "name": "Basic",
                                    "tier": "Regional"
                                }
                            },
                            "subnet": {
                                "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', parameters('virtualNetworks_DevopsCampVN_name'), 'DevopsCampSubnet')]"
                            },
                            "primary": true,
                            "privateIPAddressVersion": "IPv4",
                            "loadBalancerBackendAddressPools": [
                                {
                                    "id": "[resourceId('Microsoft.Network/loadBalancers/backendAddressPools', parameters('loadBalancers_DevopsCampRG_name'), 'backendpool')]"
                                }
                            ]
                        }
                    }
                ],
                "dnsSettings": {
                    "dnsServers": []
                },
                "enableAcceleratedNetworking": false,
                "enableIPForwarding": false,
                "disableTcpStateTracking": false,
                "networkSecurityGroup": {
                    "id": "[resourceId('Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroups_vm1nsg468_name'))]"
                },
                "nicType": "Standard"
            }
        },
        {
            "type": "Microsoft.Network/networkInterfaces",
            "apiVersion": "2022-05-01",
            "name": "[parameters('networkInterfaces_vm2712_z2_name')]",
            "location": "eastus",
            "dependsOn": [
                "[resourceId('Microsoft.Network/publicIPAddresses', parameters('publicIPAddresses_vm2_ip_name'))]",
                "[resourceId('Microsoft.Network/virtualNetworks/subnets', parameters('virtualNetworks_DevopsCampVN_name'), 'DevopsCampSubnet')]",
                "[resourceId('Microsoft.Network/loadBalancers/backendAddressPools', parameters('loadBalancers_DevopsCampRG_name'), 'backendpool')]",
                "[resourceId('Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroups_vm2_nsg_name'))]"
            ],
            "kind": "Regular",
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipconfig1",
                        "id": "[concat(resourceId('Microsoft.Network/networkInterfaces', parameters('networkInterfaces_vm2712_z2_name')), '/ipConfigurations/ipconfig1')]",
                        "etag": "W/\"5526b84c-478d-45e7-8667-286fc4296419\"",
                        "type": "Microsoft.Network/networkInterfaces/ipConfigurations",
                        "properties": {
                            "provisioningState": "Succeeded",
                            "privateIPAddress": "10.0.0.5",
                            "privateIPAllocationMethod": "Dynamic",
                            "publicIPAddress": {
                                "name": "vm2-ip",
                                "id": "[resourceId('Microsoft.Network/publicIPAddresses', parameters('publicIPAddresses_vm2_ip_name'))]",
                                "properties": {
                                    "provisioningState": "Succeeded",
                                    "resourceGuid": "acdef62d-9be1-46d2-ab20-4020e04ca70e",
                                    "publicIPAddressVersion": "IPv4",
                                    "publicIPAllocationMethod": "Dynamic",
                                    "idleTimeoutInMinutes": 4,
                                    "ipTags": [],
                                    "ipConfiguration": {
                                        "id": "[concat(resourceId('Microsoft.Network/networkInterfaces', parameters('networkInterfaces_vm2712_z2_name')), '/ipConfigurations/ipconfig1')]"
                                    },
                                    "deleteOption": "Delete"
                                },
                                "type": "Microsoft.Network/publicIPAddresses",
                                "sku": {
                                    "name": "Basic",
                                    "tier": "Regional"
                                }
                            },
                            "subnet": {
                                "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', parameters('virtualNetworks_DevopsCampVN_name'), 'DevopsCampSubnet')]"
                            },
                            "primary": true,
                            "privateIPAddressVersion": "IPv4",
                            "loadBalancerBackendAddressPools": [
                                {
                                    "id": "[resourceId('Microsoft.Network/loadBalancers/backendAddressPools', parameters('loadBalancers_DevopsCampRG_name'), 'backendpool')]"
                                }
                            ]
                        }
                    }
                ],
                "dnsSettings": {
                    "dnsServers": []
                },
                "enableAcceleratedNetworking": false,
                "enableIPForwarding": false,
                "disableTcpStateTracking": false,
                "networkSecurityGroup": {
                    "id": "[resourceId('Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroups_vm2_nsg_name'))]"
                },
                "nicType": "Standard"
            }
        }
    ]
}
