extends Node3D

@export var player_scene : PackedScene
var player
@export var player_starting_position := Vector3.ZERO

@export var farm_area_scene : PackedScene
var farm_area
@export var farm_starting_position := Vector3(10, 0, 10)

@export var water_scene : PackedScene
var water

@export var dock_scene : PackedScene
var dock
@export var dock_starting_position := Vector3(-4.25, 0.0, 0)


func _ready() -> void:
	#### CREATE SCENE CHILDREN ####
	player = player_scene.instantiate()
	player.global_position = player_starting_position
	add_child(player)
	
	farm_area = farm_area_scene.instantiate()
	farm_area.global_position = farm_starting_position
	add_child(farm_area)
	
	water = water_scene.instantiate()
	water.global_position = Vector3.ZERO
	add_child(water)
	
	dock = dock_scene.instantiate()
	dock.global_position = dock_starting_position
	add_child(dock)
