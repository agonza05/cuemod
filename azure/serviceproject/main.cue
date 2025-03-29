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
	_inputs:   locals
	_resource: vpn
	_resource: locals: _inputs
	resource: _resource.resource
}

if list.Contains(locals.enableService, "compute") {
	_inputs:   locals
	_resource: compute
	_resource: locals: _inputs
	resource: _resource.resource
}

if list.Contains(locals.enableService, "environments") {
	_inputs:   locals
	_resource: projectenvironments
	_resource: locals: _inputs
	resource: _resource.resource
}
