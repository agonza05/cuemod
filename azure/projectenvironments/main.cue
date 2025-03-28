package projectenvironments

import (
	"github.com/agonza05/cuemod/datasource/utils"
)

locals: {
	subnetCIDR: string | *"/24"
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
			address_space: [v.subnet + locals.subnetCIDR]
		}
	}
}
