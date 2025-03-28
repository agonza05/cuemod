package serviceproject

import (
	"github.com/agonza05/cuemod/datasource/utils"
	"github.com/agonza05/cuemod/datasource/cloudregions"
	azureServiceProject "github.com/agonza05/cuemod/azure/serviceproject"
)

locals: {
	cspCode:      string | *"azr"
	locationCode: string | *utils.default.cloudLocation
	regionId:     cloudregions.region[locationCode][cspCode].id
}

if locals.cspCode == "azr" {
	azureServiceProject
}
