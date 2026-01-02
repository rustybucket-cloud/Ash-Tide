extends CanvasLayer

signal inventory_button_pressed

@onready var selected_item_button = $MarginContainer/MarginContainer/HBoxContainer/SelectedItem


func _process(_delta: float) -> void:
	var selected_item = Inventory.get_selected_item()
	selected_item_button.visible = selected_item != null
	if selected_item == null:
		return
	var button_text = "Selected: " + selected_item.display_name
	if selected_item_button.text != button_text:
		selected_item_button.text = button_text


func _on_inventory_button_pressed() -> void:
	inventory_button_pressed.emit()
