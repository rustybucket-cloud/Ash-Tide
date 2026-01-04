extends CharacterBody3D

signal area_entered(area: Area3D)
signal area_exited(area: Area3D)

var current_speed = 0.0

@export var max_speed = 2.0
@export var acceleration = 1.0
@export var deceleration = 0.5
@export var turn_speed = 0.5

var bobber

func _ready() -> void:
	bobber = Bobber.new()
	bobber.set_mesh($ship)
	bobber.set_rotation_offset(0)


func move(move_input, turn_input, delta) -> void:
	if move_input != 0:
		current_speed = move_toward(current_speed, move_input * max_speed, acceleration * delta)
	else:
		current_speed = move_toward(current_speed, 0.0, deceleration * delta)

	velocity = -transform.basis.z * current_speed

	move_and_slide()

	var speed_ratio = max(abs(current_speed) / max_speed, 1)
	rotate_y(turn_input * delta * turn_speed * speed_ratio)


func _physics_process(delta: float) -> void:
	bobber.bob(delta)

	move_and_slide()


func _on_area_3d_area_entered(area: Area3D) -> void:
	area_entered.emit(area)


func _on_area_3d_area_exited(area: Area3D) -> void:
	area_exited.emit(area)
