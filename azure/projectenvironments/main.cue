package projectenvironments

import (
	"github.com/agonza05/cuemod/datasource/utils"
)

locals: {
	subnetSpaceCIDR: string | *"/24"
	subnet1CIDR:     string | *"/26"
}

resource: {
	for k, v in locals.projectEnvironments {
		let resourceId = locals.workspaceId + "-" + k
		azurerm_resource_group: "\(resourceId)": {
			name:     utils.prefix.cloud.resGroup + "-" + resourceId
			location: locals.regionId
		}
		azurerm_virtual_network: "\(resourceId)": {
			name:                utils.prefix.cloud.vpc + "-" + resourceId
			resource_group_name: "${azurerm_resource_group.\(resourceId).name}"
			location:            "${azurerm_resource_group.\(resourceId).location}"
			address_space: [v.subnet + locals.subnetSpaceCIDR]
		}
		azurerm_subnet: "\(resourceId)": {
			name:                 utils.prefix.cloud.subnet + "-" + resourceId + "-1"
			resource_group_name:  "${azurerm_resource_group.\(resourceId).name}"
			virtual_network_name: "${azurerm_virtual_network.\(resourceId).name}"
			address_prefixes: [v.subnet + locals.subnet1CIDR]
		}
	}
}
