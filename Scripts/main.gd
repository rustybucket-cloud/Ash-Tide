extends Node3D

@export var player_scene : PackedScene
var player

@export var farm_area_scene : PackedScene
var farm_area

@export var water_scene : PackedScene
var water


func _ready() -> void:
	#### CREATE SCENE CHILDREN ####
	player = player_scene.instantiate()
	player.global_position = Vector3.ZERO
	add_child(player)
	
	farm_area = farm_area_scene.instantiate()
	farm_area.global_position = Vector3.ZERO
	add_child(farm_area)
	
	water = water_scene.instantiate()
	water.global_position = Vector3.ZERO
	add_child(water)


func _physics_process(delta: float) -> void:
	var move_input = Input.get_axis("move_backward", "move_forward")
	var turn_input = Input.get_axis("rotate_right", "rotate_left")
	
	player.move(move_input, turn_input, delta)
	
