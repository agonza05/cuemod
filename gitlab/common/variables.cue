package common

variables: {
	// GitLab CI global parameters
	GIT_STRATEGY: "clone" // Preferring a shallow, full clone
	GIT_DEPTH:    "3"     // Using 3 as 1 may failed for a queue of jobs

	// AAI CI global parameters
	CONFIRM_PIPELINE:          "confirm"                   // Pipelines require manual execution by default
	ACTION_PATTERN:            "/^(deploy|destroy|skip)$/" // Possible pipeline stages. Skip if user inputs any other value
	RUNNER_CICD_IMAGE_VERSION: "latest"                    // aaicicd docker image version: https://repository.aai.sh/repository/docker-infra/
	RUNNER_TAG:                "glrun-docker"              // Default runner tag
}
