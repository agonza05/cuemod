package cloudregions

country: {
	de: name: "Germany"
	us: name: "United States"
	uk: name: "United Kingdom"
	ie: name: "Ireland"
	nl: name: "Netherlands"
	fi: name: "Finland"
	se: name: "Sweden"
	no: name: "Norway"
	it: name: "Italy"
	fr: name: "France"
	br: name: "Brazil"
	nz: name: "New Zealand"
	au: name: "Australia"
	cl: name: "Chile"
}

contryObjectKeys: [for k, v in country {k}]

#Country: [ID=#TwoLetterCode]: {
	name!:        string
	description?: string
	id:           ID
	location: {...}
}

country: #Country

for k, v in location {
	country: "\(v.countryCode)": location: "\(k)": v
}
