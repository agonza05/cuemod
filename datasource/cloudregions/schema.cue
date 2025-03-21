package cloudregions

#ThreeLetterCode: =~"^[a-z]{3}$"
#TwoLetterCode:   =~"^[a-z][a-z]$"

#Country: [ID=#TwoLetterCode]: {
	name!:        string
	description?: string
	id:           ID
	location: {...}
}

country: #Country
_contryObjectKeys: [for k, v in country {k}]

#Location: [ID=#ThreeLetterCode]: {
	name!:       string
	countryCode: or(_contryObjectKeys)
	countryName: country[countryCode].name
	id:          ID
	cloudRegion: {...}
}

location: #Location

#CloudProvider: [ID=#ThreeLetterCode]: {
	name!:        string
	description?: string
	id:           ID
	location: {...}
}

cloudProvider: #CloudProvider

#RegionCodes: [ID=string]: {
	name!:               string
	description?:        string
	cloudProvider:       or(_cloudProviderObjectKeys)
	location:            location[location].id
	cloudProviderRegion: region[location][cloudProvider]
	id:                  ID
}

#CloudRegion: [or(_locationObjectKeys)]: [or(_cloudProviderObjectKeys)]: {
	displayName!: string
	name:         name
	id:           name
}

region: #CloudRegion

_cloudProviderObjectKeys: [for k, v in cloudProvider {k}]
_locationObjectKeys: [for k, v in location {k}]

for k, v in region {
	location: "\(k)": cloudRegion: v
	let _loc = location
	for x, y in v {
		cloudProvider: "\(x)": location: "\(k)": {
			name:        _loc[k].name
			countryCode: _loc[k].countryCode
			countryName: _loc[k].countryName
			id:          _loc[k].id
			cloudRegion: y
		}
	}
}

for k, v in location {
	country: "\(v.countryCode)": location: "\(k)": v
}
