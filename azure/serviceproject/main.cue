package serviceproject

import (
	"list"
	"github.com/agonza05/cuemod/azure/provider"
	"github.com/agonza05/cuemod/azure/vpn"
	"github.com/agonza05/cuemod/azure/compute"
	"github.com/agonza05/cuemod/azure/bucket"
	"github.com/agonza05/cuemod/azure/projectenvironments"
)

locals: {...}

provider

_inputs: locals
_resource: locals: _inputs
resource: _resource.resource

if list.Contains(locals.enableService, "vpn") {_resource: vpn}

if list.Contains(locals.enableService, "compute") {_resource: compute}

if list.Contains(locals.enableService, "environments") {_resource: projectenvironments}

if list.Contains(locals.enableService, "bucket") {_resource: bucket}
