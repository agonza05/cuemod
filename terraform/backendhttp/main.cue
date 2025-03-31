package backendhttp

import (
	utils "github.com/agonza05/cuemod/datasource/utils"
)

locals: {
	workspaceId: string
	tfStateName: string | *"\(utils.prefix.terraform.stateFile)-\(workspaceId)"
	// "https://gitlab.com/api/v4/projects/55066401/terraform/state/"
	tfStateAddress: string
	...
}

terraform: backend: http: {
	address:        locals.tfStateAddress + locals.tfStateName
	lock_address:   address + "/lock"
	unlock_address: address + "/lock"
	lock_method:    "POST"
	unlock_method:  "DELETE"
	retry_wait_min: 5
}
