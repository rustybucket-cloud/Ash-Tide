extends CanvasLayer

signal inventory_button_pressed


func _on_inventory_button_pressed() -> void:
	inventory_button_pressed.emit()
