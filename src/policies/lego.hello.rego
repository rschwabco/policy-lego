package play

import future.keywords.in

default allow = false

Links := input.user.attributes.properties.Links

PropertyGroups := data.property_groups

allow {
	some i
	Groups := Links[i].Groups
	Customers := Links[i].Customers

	some group in Groups
	some propertyGroup, _ in PropertyGroups
	propertyGroup == group

	some userCustomer in Customers
	userCustomer == input.resource.accessingCustomer
}

allow {
	some i
	Groups := Links[i].Groups
	Customers := Links[i].Customers

	some group in Groups
	some propertyGroup, _ in PropertyGroups
	propertyGroup == group

	some userCustomer in Customers
	customer := data.customer_hierarchy[userCustomer]

	some child in customer.Children
	child == input.resource.accessingCustomer
}
