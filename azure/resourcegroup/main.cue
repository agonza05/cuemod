package resourcegroup

import (
	#Utils "github.com/agonza05/cuemod/datasource/utils"
)

locals: {}

resource: azurerm_resource_group: "\(locals.workspaceId)": {
	name:     "\(#Utils.prefix.cloud.resGroup)-\(locals.workspaceId)-vpn"
	location: locals.regionId
}
