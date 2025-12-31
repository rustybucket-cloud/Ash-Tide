extends CanvasLayer

@onready var harvest_button = $HarvestButton

func _ready() -> void:
	harvest_button.visible = false


func show_harvest_button() -> void:
	harvest_button.visible = true
	

func hide_harvest_button() -> void:
	harvest_button.visible = false
