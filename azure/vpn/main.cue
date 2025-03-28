package vpn

import (
	utils "github.com/agonza05/cuemod/datasource/utils"
)

locals: {
	vpnSubnetCIDR: string | *"/24"
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
}
