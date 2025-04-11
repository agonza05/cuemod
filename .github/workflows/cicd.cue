package cicd

// import "cue.dev/x/githubactions"

// workflows: example: githubactions.#Workflow & {
workflows: tags: {
	name: "Create git tag"
	on: push: branches: ["main"]

	jobs: "create-git-tag": {
		"runs-on": "ubuntu-latest"
		permissions: contents: "write"
		steps: [
			{uses: "actions/checkout@v4", with: "fetch-depth": "0"},
			{uses: "anothrNick/github-tag-action@v1", env: {
				GITHUB_TOKEN: "${{ secrets.GITHUB_TOKEN }}"
				WITH_V:       true
			}},
		]
	}
}

workflows: publish: {
	name: "Publish CUE module"
	on: create: tags: ["*"]
	env: {
		REGISTRY:   "ghcr.io"
		IMAGE_NAME: "${{ github.repository }}"
	}

	jobs: publish: {
		"runs-on": "ubuntu-latest"
		permissions: {
			contents:     "read"
			packages:     "write"
			attestations: "write"
			"id-token":   "write"
		}
		steps: [
			{uses: "actions/checkout@v4"},
			{uses: "cue-lang/setup-cue@v1.0.1"},
			{uses: "docker/login-action@v3.4.0", with: {
				registry: "${{ env.REGISTRY }}"
				username: "${{ github.actor }}"
				password: "${{ secrets.GITHUB_TOKEN }}"
			}},
			{run: "cue mod publish ${{ github.ref_name }}", env: CUE_REGISTRY: "${{ env.REGISTRY }}"},
		]
	}
}
