package cicd

// import "cue.dev/x/githubactions"

workflows: publish: {
	name: "Publish CUE module"
	on: push: branches: ["main"]
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
			{uses: "actions/checkout@v4", with: "fetch-depth": "0"},
			{uses: "anothrNick/github-tag-action@v1", id: "gittag", env: {
				GITHUB_TOKEN: "${{ secrets.GITHUB_TOKEN }}"
				WITH_V:       true
			}},
			{uses: "cue-lang/setup-cue@v1.0.1"},
			{uses: "docker/login-action@v3.4.0", with: {
				registry: "${{ env.REGISTRY }}"
				username: "${{ github.actor }}"
				password: "${{ secrets.GITHUB_TOKEN }}"
			}},
			{run: "cue mod publish ${{ steps.gittag.outputs.new_tag }}", env: CUE_REGISTRY: "${{ env.REGISTRY }}"},
		]
	}
}
