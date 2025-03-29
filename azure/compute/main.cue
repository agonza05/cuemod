package compute

import (
	utils "github.com/agonza05/cuemod/datasource/utils"
)

locals: {
	computeSubnetSpaceCIDR: string | *"/24"
	computeSubnet1CIDR:     string | *"/26"
}

_resourceId: locals.workspaceId + "-apps"

resource: {
	azurerm_resource_group: "\(_resourceId)": {
		name:     utils.prefix.cloud.resGroup + "-" + _resourceId
		location: locals.regionId
	}
	azurerm_virtual_network: "\(_resourceId)": {
		name:                utils.prefix.cloud.vpc + "-" + _resourceId
		resource_group_name: "${azurerm_resource_group.\(_resourceId).name}"
		location:            "${azurerm_resource_group.\(_resourceId).location}"
		address_space: [locals.computeSubnet + locals.computeSubnetSpaceCIDR]
	}
	azurerm_subnet: "\(_resourceId)": {
		name:                 utils.prefix.cloud.subnet + "-" + _resourceId + "-1"
		resource_group_name:  "${azurerm_resource_group.\(_resourceId).name}"
		virtual_network_name: "${azurerm_virtual_network.\(_resourceId).name}"
		address_prefixes: [locals.computeSubnet + locals.computeSubnet1CIDR]
	}
}
