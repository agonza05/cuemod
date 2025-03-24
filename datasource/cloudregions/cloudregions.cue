package cloudregions

region: {
	ber: {
		gcp: {displayName: "Berlin", name: "europe-west10"}
		azr: {displayName: "Germany North (Berlin)", name: "germanynorth"}
	}
	fra: {
		aws: {displayName: "Europe Central (Frankfurt)", name: "eu-central-1"}
		azr: {displayName: "Germany West Central (Frankfurt)", name: "germanywestcentral"}
		gcp: {displayName: "Frankfurt", name: "europe-west3"}
		oci: {displayName: "Germany Central (Frankfurt)", name: "eu-frankfurt-1"}
	}
	dub: {
		aws: {displayName: "Europe West (Ireland)", name: "eu-west-1"}
		azr: {displayName: "North Europe (Dublin)", name: "northeurope"}
	}
	hel: {
		azr: {displayName: "Finland (Helsinki)", name: "finlandcentral"}
	}
	hmx: {
		gcp: {displayName: "Finland", name: "europe-north1"}
	}
	osl: {
		azr: {displayName: "Norway East (Oslo)", name: "norwayeast"}
	}
	arn: {
		aws: {displayName: "Europe North (Stockholm)", name: "eu-north-1"}
		oci: {displayName: "Sweden Central (Stockholm)", name: "eu-stockholm-1"}
	}
	sfo: {
		aws: {displayName: "US West (Northern California)", name: "us-west-2"}
		azr: {displayName: "West US (San Francisco)", name: "westus"}
		oci: {displayName: "US West (San Jose)", name: "us-sanjose-1"}
	}
	iad: {
		aws: {displayName: "US East (Northern Virginia)", name: "us-east-1"}
		gcp: {displayName: "Northern Virginia", name: "us-east4"}
		oci: {displayName: "US East (Ashburn)", name: "us-ashburn-1"}
	}
	gru: {
		aws: {displayName: "South America (São Paulo)", name: "sa-east-1"}
		azr: {displayName: "Brazil South (São Paulo)", name: "brazilsouth"}
		gcp: {displayName: "Sao Paulo", name: "southamerica-east1"}
		oci: {displayName: "Brazil East (Sao Paulo)", name: "sa-saopaulo-1"}
	}
	scl: {
		azr: {displayName: "Chile Central (Santiago)", name: "chilecentral"}
		gcp: {displayName: "Santiago", name: "southamerica-west1"}
		oci: {displayName: "Chile Central (Santiago)", name: "sa-santiago-1"}
	}
	gru: {
		aws: {displayName: "South America (São Paulo)", name: "sa-east-1"}
		azr: {displayName: "Brazil South (São Paulo)", name: "brazilsouth"}
		gcp: {displayName: "Sao Paulo", name: "southamerica-east1"}
		oci: {displayName: "Brazil East (Sao Paulo)", name: "sa-saopaulo-1"}
	}
	par: {
		aws: {displayName: "Europe West (Paris)", name: "eu-west-3"}
		azr: {displayName: "France Central (Paris)", name: "francecentral"}
		gcp: {displayName: "Paris", name: "europe-west9"}
		oci: {displayName: "France Central (Paris)", name: "eu-paris-1"}
	}
	lon: {
		aws: {displayName: "Europe West (London)", name: "eu-west-2"}
		azr: {displayName: "UK South (London)", name: "uksouth"}
		gcp: {displayName: "London", name: "europe-west2"}
		oci: {displayName: "UK South (London)", name: "uk-london-1"}
	}
	syd: {
		aws: {displayName: "Asia Pacific (Sydney)", name: "ap-southeast-2"}
		azr: {displayName: "Australia East (Sydney)", name: "australiaeast"}
		gcp: {displayName: "Sydney", name: "australia-southeast1"}
		oci: {displayName: "Australia East (Sydney)", name: "ap-sydney-1"}
	}
}

#RegionCodes: [ID=string]: {
	name!:               string
	description?:        string
	cloudProvider:       or(cloudProviderObjectKeys)
	location:            location[location].id
	cloudProviderRegion: region[location][cloudProvider]
	id:                  ID
}

#CloudRegion: [or(locationObjectKeys)]: [or(cloudProviderObjectKeys)]: {
	displayName!: string
	name:         name
	id:           name
}

region: #CloudRegion
