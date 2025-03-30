package vpn

import (
	utils "github.com/agonza05/cuemod/datasource/utils"
)

locals: {
	vpnSubnetCIDR: string | *"/24"
	dcSubnets: [...string] | *["192.168.0.0/16"]
	vpnGatewayIp: string | *"185.197.236.33"
}

_resourceId: locals.workspaceId + "-vpn"

resource: {
	azurerm_resource_group: "\(_resourceId)": {
		name:     utils.prefix.cloud.resGroup + "-" + _resourceId
		location: locals.regionId
	}

	azurerm_virtual_network: "\(_resourceId)": {
		name:                utils.prefix.cloud.vpc + "-" + _resourceId
		resource_group_name: "${azurerm_resource_group.\(_resourceId).name}"
		location:            "${azurerm_resource_group.\(_resourceId).location}"
		address_space: [locals.vpnSubnet + locals.vpnSubnetCIDR]
	}

	azurerm_subnet: "\(_resourceId)": {
		name:                 "GatewaySubnet"
		resource_group_name:  "${azurerm_resource_group.\(_resourceId).name}"
		virtual_network_name: "${azurerm_virtual_network.\(_resourceId).name}"
		address_prefixes: [locals.vpnSubnet + locals.vpnSubnetCIDR]
	}

	azurerm_public_ip: "\(_resourceId)": {
		name:                utils.prefix.cloud.ipAddress + "-" + _resourceId + "-vpn"
		resource_group_name: "${azurerm_resource_group.\(_resourceId).name}"
		location:            "${azurerm_resource_group.\(_resourceId).location}"
		allocation_method:   "Dynamic"
		sku:                 "Basic"
	}

	azurerm_local_network_gateway: "\(_resourceId)": {
		name:                utils.prefix.cloud.site + "-" + _resourceId + "-dc"
		resource_group_name: "${azurerm_resource_group.\(_resourceId).name}"
		location:            "${azurerm_resource_group.\(_resourceId).location}"
		gateway_address:     locals.vpnGatewayIp
		address_space:       locals.dcSubnets
	}

	azurerm_virtual_network_gateway: "\(_resourceId)": {
		name:                utils.prefix.cloud.site + "-" + _resourceId + "-1"
		resource_group_name: "${azurerm_resource_group.\(_resourceId).name}"
		location:            "${azurerm_resource_group.\(_resourceId).location}"
		type:                "Vpn"
		vpn_type:            "RouteBased"
		sku:                 "Basic"
		ip_configuration: {
			public_ip_address_id: "${azurerm_public_ip.\(_resourceId).id}"
			subnet_id:            "${azurerm_subnet.\(_resourceId).id}"
		}
	}

	azurerm_virtual_network_gateway_connection: "\(_resourceId)": {
		name:                       utils.prefix.cloud.vpn + "-" + _resourceId + "-1"
		resource_group_name:        "${azurerm_resource_group.\(_resourceId).name}"
		location:                   "${azurerm_resource_group.\(_resourceId).location}"
		virtual_network_gateway_id: "${azurerm_virtual_network_gateway.\(_resourceId).id}"
		local_network_gateway_id:   "${azurerm_local_network_gateway.\(_resourceId).id}"
		type:                       "IPsec"
		shared_key:                 locals.vpnSharedSecret
	}
}
