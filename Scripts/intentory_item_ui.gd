extends Panel

@onready var label = $Label
@onready var count_label = $CountContainer/CountLabel

var inventory_item : InventoryItem
var panel_index = -1

@export var base_border_color = "#262626"

func _process(_delta: float) -> void:
	var base := get_theme_stylebox("panel")
	var sb: StyleBox = base.duplicate(true)
	if Inventory.selected_item == panel_index:
		if sb is StyleBoxFlat:
			(sb as StyleBoxFlat).border_color = "#F0B58B"
			add_theme_stylebox_override("panel", sb)
	else:
		if sb is StyleBoxFlat:
			(sb as StyleBoxFlat).border_color = base_border_color
			add_theme_stylebox_override("panel", sb)


func set_inventory_item(it: InventoryItem) -> void:
	inventory_item = it
	if inventory_item.display_name != label.text:
		label.text = inventory_item.display_name
	var count_text = "Count: " + str(inventory_item.count)
	if count_text != count_label.text:
		count_label.text = count_text


func clear_inventory_item() -> void:
	inventory_item = null
	label.text = ""
	count_label.text = ""


func _on_invisible_button_pressed() -> void:
	assert(panel_index != -1)
	
	# clear selected item
	if panel_index == Inventory.selected_item:
		Inventory.selected_item = -1
		return

	Inventory.selected_item = panel_index
