package common

".jobs:validate": {
	stage: "validate"
	environment: name: "$SERVICE_NAME"
	resource_group: "$SERVICE_NAME"
	tags: ["$RUNNER_TAG"]
	rules: [{if: "$PIPELINE_ACTION" // Cannot edit this rule or triggers will fail for skipped jobs
	}]
}
".jobs:plan": {
	stage: "plan"
	environment: name: "$SERVICE_NAME"
	resource_group: "$SERVICE_NAME"
	tags: ["$RUNNER_TAG"]
	rules: [{if: "$PIPELINE_ACTION == \"deploy\" || $PIPELINE_ACTION == \"destroy\""}]
}
".jobs:deploy": {
	stage: "deploy"
	environment: name: "$SERVICE_NAME"
	resource_group: "$SERVICE_NAME"
	tags: ["$RUNNER_TAG"]
	rules: [{
		if: "$PIPELINE_ACTION == \"deploy\" && $CONFIRM_PIPELINE == \"skip\""
	}, {
		if:   "$PIPELINE_ACTION == \"deploy\" && $CONFIRM_PIPELINE == \"confirm\""
		when: "manual"
	}]
}
".jobs:destroy": {
	stage: "destroy"
	environment: name: "$SERVICE_NAME"
	resource_group: "$SERVICE_NAME"
	tags: ["$RUNNER_TAG"]
	rules: [{
		if:   "$PIPELINE_ACTION == \"destroy\""
		when: "manual"
	}]
}
