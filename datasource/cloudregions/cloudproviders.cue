package cloudregions

cloudProvider: {
	gcp: name: "Google Cloud Platform"
	azr: name: "Microsoft Azure"
	aws: name: "Amazon Web Services"
	oci: name: "Oracle Cloud Infrastructure"
}

cloudProviderObjectKeys: [for k, v in cloudProvider {k}]

#CloudProvider: [ID=#ThreeLetterCode]: {
	name!:        string
	description?: string
	id:           ID
	location: {...}
}

cloudProvider: #CloudProvider
