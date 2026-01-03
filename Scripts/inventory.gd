extends Node

var SLOT_COUNT = 25
var MAX_SLOT_AMOUNT = 10

var items: Array[InventoryItem] = []

var selected_item : int = -1

func _ready() -> void:
	for i in SLOT_COUNT:
		items.append(null)

	var initial_seaweed_seed = InventoryItem.new()
	initial_seaweed_seed.display_name = "Seaweed Seed"
	initial_seaweed_seed.value = 10
	initial_seaweed_seed.count = 1
	items[0] = initial_seaweed_seed
	
	var initial_farm_area = InventoryItem.new()
	initial_farm_area.display_name = "Farm Area"
	initial_farm_area.value = 100
	initial_farm_area.count = 1
	items[1] = initial_farm_area


func add_item(item: InventoryItem, slot: int) -> void:
	if items[slot] == null:
		items[slot] = item
		return

	assert(items[slot].display_name == item.display_name)
	assert(items[slot].count <= MAX_SLOT_AMOUNT)
	items[slot].count += 1


func remove_item(slot: int) -> void:
	assert(slot <= items.size() - 1)
	if items[slot] == null:
		return
	
	items[slot].count -= 1
	if items[slot].count < 1:
		items[slot] = null
		if selected_item == slot:
			selected_item = -1


func remove_selected_item() -> void:
	remove_item(selected_item)


func get_available_slot(item: InventoryItem) -> Array[int]:
	var available_slots = []
	for i in SLOT_COUNT:
		if items[i] == null:
			available_slots.append(i)
			continue
		if items[i].display_name != item.display_name:
			continue
		if items[i] >= MAX_SLOT_AMOUNT:
			continue
		available_slots.append(i)
	
	return available_slots


func get_selected_item() -> InventoryItem:
	if selected_item == -1:
		return null
	return items[selected_item]
