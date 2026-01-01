extends CanvasLayer

signal close_button_pressed

@onready var grid = $GridContainer

func _on_close_button_pressed() -> void:
	close_button_pressed.emit()
