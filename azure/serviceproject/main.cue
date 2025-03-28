package serviceproject

import (
	"list"
	"github.com/agonza05/cuemod/azure/provider"
	"github.com/agonza05/cuemod/azure/vpn"
	"github.com/agonza05/cuemod/azure/compute"
	"github.com/agonza05/cuemod/azure/projectenvironments"
)

locals: {...}

provider

if list.Contains(locals.enableService, "vpn") {
	let inputs = locals
	_reosurce: vpn
	_reosurce: locals: inputs
	resource: _reosurce.resource
}

if list.Contains(locals.enableService, "compute") {
	let inputs = locals
	_reosurce: compute
	_reosurce: locals: inputs
	resource: _reosurce.resource
}

if list.Contains(locals.enableService, "environments") {
	let inputs = locals
	_reosurce: projectenvironments
	_reosurce: locals: inputs
	resource: _reosurce.resource
}
