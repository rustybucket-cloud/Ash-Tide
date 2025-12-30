extends Node3D

@onready var boat = $Boat

func _physics_process(delta: float) -> void:
	var move_input = Input.get_axis("move_backward", "move_forward")
	var turn_input = Input.get_axis("rotate_right", "rotate_left")
	
	boat.move(move_input, turn_input, delta)
