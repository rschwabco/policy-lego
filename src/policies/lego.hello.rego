package lego.hello.rego

import future.keywords.in

default allowed = false

Links := input.user.attributes.properties.Links

PropertyGroups := data.property_groups

allowed {
	some i
	Groups := Links[i].Groups
	Customers := Links[i].Customers

	some group in Groups
	group == input.resource.group

	some userCustomer in Customers
	userCustomer == input.resource.customer
}

allowed {
	some i
	Groups := Links[i].Groups
	Customers := Links[i].Customers

	some group in Groups
	some child in PropertyGroups[group]
	child == input.resource.group

	some userCustomer in Customers
	customer := data.customer_hierarchy[userCustomer]

	some pchild in customer.Children
	pchild == input.resource.customer
}

allowed {
	some i
	Groups := Links[i].Groups
	Customers := Links[i].Customers

	some group in Groups
	some child in PropertyGroups[group].Children
	child == input.resource.group

	some userCustomer in Customers
	userCustomer == input.resource.customer
}

allowed {
	some i
	Groups := Links[i].Groups
	Customers := Links[i].Customers

	some group in Groups
	some propertyGroup, _ in PropertyGroups
	propertyGroup == group

	some userCustomer in Customers
	customer := data.customer_hierarchy[userCustomer]

	some child in customer.Children
	child == input.resource.customer
}
