package cloudregions

location: {
	fra: {name: "Frankfurt", countryCode: "de"}
	ber: {name: "Berlin", countryCode: "de"}
	dub: {name: "Dublin", countryCode: "ie"}
	hel: {name: "Helsinki", countryCode: "fi"}
	hmx: {name: "Hamina", countryCode: "fi"}
	osl: {name: "Oslo", countryCode: "no"}
	arn: {name: "Stockholm", countryCode: "se"}
	lon: {name: "London", countryCode: "uk"}
	mil: {name: "Milan", countryCode: "it"}
	par: {name: "Paris", countryCode: "fr"}
	gru: {name: "São Paulo", countryCode: "br"}
	akl: {name: "Auckland", countryCode: "nz"}
	syd: {name: "Sydney", countryCode: "au"}
	iad: {name: "Washington", countryCode: "us"}
	sfo: {name: "San Francisco", countryCode: "us"}
	scl: {name: "Santiago", countryCode: "cl"}
}

locationObjectKeys: [for k, v in location {k}]

#Location: [ID=#ThreeLetterCode]: {
	name!:       string
	countryCode: or(contryObjectKeys)
	countryName: country[countryCode].name
	id:          ID
	cloudRegion: {...}
}

location: #Location

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
