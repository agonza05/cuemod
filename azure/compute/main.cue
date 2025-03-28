package compute

import (
	utils "github.com/agonza05/cuemod/datasource/utils"
)

locals: {
	computeSubnetCIDR: string | *"/24"
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
		address_space: [locals.computeSubnet + locals.computeSubnetCIDR]
	}
}
