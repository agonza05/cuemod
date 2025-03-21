package terragrunt

terraform: {
	source: "./"
	include_in_copy: ["*.tf.json", "*.tfvars.json"]
}
