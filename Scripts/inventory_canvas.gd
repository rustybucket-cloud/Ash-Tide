extends CanvasLayer

signal close_button_pressed

@export var inventory_item_ui_scene : PackedScene

@onready var grid = $MarginContainer/VBoxContainer/GridContainer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	for i in range(Inventory.SLOT_COUNT):
		var slot = inventory_item_ui_scene.instantiate()
		slot.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		slot.size_flags_vertical = Control.SIZE_EXPAND_FILL
		slot.custom_minimum_size = Vector2(64, 64)
		slot.panel_index = i
		grid.add_child(slot)
		#slot.slot_index = i


func _process(_delta: float) -> void:
	# set the correct item to each ui item
	var inventory_item_children = grid.find_children("*", "Panel", true, false)
	for i in range(len(inventory_item_children)):
		if Inventory.items[i] != null:
			inventory_item_children[i].set_inventory_item(Inventory.items[i])
		else:
			inventory_item_children[i].clear_inventory_item()


func _on_close_button_pressed() -> void:
	close_button_pressed.emit()
