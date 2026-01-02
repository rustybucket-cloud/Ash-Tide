extends GutTest

func test_inventory_setup():
	var inventory = Inventory.new()
	assert_eq(len(inventory.items), 25)

#func test_passes():
	#assert_eq(1, 1)
	#
#
#func test_fails():
	#assert_eq(1, 2)
