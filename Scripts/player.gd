extends CharacterBody3D

var current_speed = 0.0

@export var max_speed = 5.0
@export var acceleration = 1.0
@export var deceleration = 0.5
@export var max_turn_speed = 2.0

var bobber

func _ready() -> void:
	bobber = Bobber.new()
	bobber.set_mesh($MeshInstance3D)
	bobber.set_rotation_offset(90)
	

func move(move_input, turn_input, delta) -> void:
	if move_input != 0:
		current_speed = move_toward(current_speed, move_input * max_speed, acceleration * delta)
	else:
		current_speed = move_toward(current_speed, 0.0, deceleration * delta)

	var speed_ratio = abs(current_speed) / max_speed
	var turn_speed = lerp(0.0, max_turn_speed, speed_ratio)

	rotate_y(turn_input * delta * turn_speed)
	velocity = -transform.basis.z * current_speed
	
	move_and_slide()


func _physics_process(delta: float) -> void:
	bobber.bob(delta)

	move_and_slide()
