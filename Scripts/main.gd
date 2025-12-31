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

@export var farm_canvas_scene : PackedScene
var farm_canvas

func _ready() -> void:
	#### CREATE SCENE CHILDREN ####
	player = player_scene.instantiate()
	player.global_position = player_starting_position
	add_child(player)
	
	farm_area = farm_area_scene.instantiate()
	farm_area.global_position = farm_starting_position
	farm_area.player_entered.connect(_on_farm_area_player_entered)
	farm_area.player_exited.connect(_on_farm_area_player_exited)
	add_child(farm_area)
	
	water = water_scene.instantiate()
	water.global_position = Vector3.ZERO
	add_child(water)
	
	dock = dock_scene.instantiate()
	dock.global_position = dock_starting_position
	add_child(dock)
	
	farm_canvas = farm_canvas_scene.instantiate()
	add_child(farm_canvas)
	

func _on_farm_area_player_entered() -> void:
	farm_canvas.show_harvest_button()
	

func _on_farm_area_player_exited() -> void:
	farm_canvas.hide_harvest_button()


func _dock_player() -> void:
	pass
