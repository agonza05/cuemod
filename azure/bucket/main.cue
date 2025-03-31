package bucket

import (
	"strings"
	utils "github.com/agonza05/cuemod/datasource/utils"
)

locals: {
	storageTier:  string | *"Standard"
	storageType:  string | *"LRS"
	accessTier:   string | *"Cool"
	accessType:   string | *"private"
	publicAccess: bool | *false
}

_resourceId: locals.workspaceId + "-bkt"

resource: {
	azurerm_resource_group: "\(_resourceId)": {
		name:     utils.prefix.cloud.resGroup + "-" + _resourceId
		location: locals.regionId
	}
	azurerm_storage_account: "\(_resourceId)": {
		_name:                         utils.prefix.cloud.bucket + "-" + _resourceId
		name:                          strings.Join(strings.Split(_name, "-"), "")
		resource_group_name:           "${azurerm_resource_group.\(_resourceId).name}"
		location:                      "${azurerm_resource_group.\(_resourceId).location}"
		account_tier:                  locals.storageTier
		account_replication_type:      locals.storageType
		access_tier:                   locals.accessTier
		public_network_access_enabled: locals.publicAccess
	}
	for i in locals.buckets {
		azurerm_storage_container: "\(_resourceId)-\(i)": {
			name:                  i
			storage_account_id:    "${azurerm_storage_account.\(_resourceId).id}"
			container_access_type: locals.accessType
		}
	}
}
