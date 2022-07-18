package lego.api.__customer.__group

import future.keywords.in

default allowed = false

Links := input.user.attributes.properties.Links

PropertyGroups := data.property_groups

CustomerHierarchy := data.customer_hierarchy

# Requested group and customer match user's group and customer
allowed {
	some i
	userGroups := Links[i].Groups
	userCustomers := Links[i].Customers

	some userGroup in userGroups
	userGroup == input.resource.group

	some userCustomer in userCustomers
	userCustomer == input.resource.customer
}

# Requested group and customer match user's child customer and assigned group
allowed {
	some i
	userGroups := Links[i].Groups
	userCustomers := Links[i].Customers

	# Compare the user's assigned group to the requested group
	some userGroup in userGroups
	userGroup == input.resource.group

	# Get the customer from the CustomerHierarchy based on the user's customer
	some userCustomer in userCustomers
	customer := CustomerHierarchy[userCustomer]

	# Compare one of the child customers to the requested customer
	some childCustomer in customer.Children
	childCustomer == input.resource.customer
}

# Requested group and customer match user's child group and assigned customer
allowed {
	some i
	userGroups := Links[i].Groups
	userCustomers := Links[i].Customers

	# Resolve the property group to resolve the group's children
	some userGroup in userGroups
	group := PropertyGroups[userGroup]

	# Compare one of the child groups to the requested group
	some childGroup in group.Children
	childGroup == input.resource.group

	# Compare the user assigned customers to the requested customer
	some userCustomer in userCustomers
	userCustomer == input.resource.customer
}

allowed {
	some i
	userGroups := Links[i].Groups
	userCustomers := Links[i].Customers

	# Resolve the property group to resolve the group's children
	some userGroup in userGroups
	group := PropertyGroups[userGroup]

	# Compare one of the child groups to the requested group
	some childGroup in group.Children
	childGroup == input.resource.group

	# Get the customer from the CustomerHierarchy based on the user's customer
	some userCustomer in userCustomers
	customers := CustomerHierarchy[userCustomer]

	# Compare one of the child customers to the requested customer
	some childCustomer in customers.Children
	childCustomer == input.resource.customer
}
