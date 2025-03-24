package serviceproject

import (
	#Utils "github.com/agonza05/cuemod/datasource/utils"
	#CloudRegions "github.com/agonza05/cuemod/datasource/cloudregions"
	#AzureServiceProject "github.com/agonza05/cuemod/azure/serviceproject"
)

locals: {
	cspCode:      string | *"azr"
	locationCode: string | *#Utils.default.cloudLocation
	regionId:     #CloudRegions.region[locationCode][cspCode].id
}

if locals.cspCode == "azr" {
	#AzureServiceProject
}
