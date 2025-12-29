extends Node

class_name Bobber

var mesh: MeshInstance3D

var bob_time = 0.0
@export var bob_amount = 0.1
var bob_speed = 1.2

var speed_ratio = 0.0
var _rotation_offset = 0.0


func set_mesh(new_mesh: MeshInstance3D) -> void:
	mesh = new_mesh
	

func set_speed(speed: float) -> void:
	speed_ratio = speed
	

func set_rotation_offset(offset: float) -> void:
	_rotation_offset = offset


func bob(delta: float) -> void:
	if mesh == null:
		print("No mesh added for Bobber")
		return

	bob_time += delta * bob_speed
	var bob_intensity = lerp(bob_amount, bob_amount * 0.3, speed_ratio)
	var bob_value = sin(bob_time) * bob_intensity
	mesh.rotation.x = _rotation_offset + bob_value
	mesh.position.y = bob_value
