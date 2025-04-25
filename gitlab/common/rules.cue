package common

workflow: rules: [{
	if:   "$CI_COMMIT_TAG"
	when: "never"
}, {
	if:   "$PIPELINE_ACTION !~ $ACTION_PATTERN"
	when: "never"
}, {
	if: "$CI_MERGE_REQUEST_TARGET_BRANCH_NAME == $CI_DEFAULT_BRANCH"
}, {
	if: "$CI_PIPELINE_SOURCE == \"web\" || $CI_PIPELINE_SOURCE == \"pipeline\" || $CI_PIPELINE_SOURCE == \"parent_pipeline\""
}, {
	if: "$CI_COMMIT_BRANCH != $CI_DEFAULT_BRANCH"
}]

stages: [
	"validate",
	"plan",
	"deploy",
	"destroy",
]
