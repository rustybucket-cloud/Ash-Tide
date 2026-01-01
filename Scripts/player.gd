extends Node3D

@export var farm_area_scene : PackedScene
@export var new_farm_area_scene : PackedScene
var new_farm_area = null

@onready var boat = $Boat
@onready var detector = $Boat/TriggerDetector

var is_new_farm_placement_disabled := false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("available_action"):
		if new_farm_area == null:
			### Start new farm placement ###
			new_farm_area = new_farm_area_scene.instantiate()
			get_tree().current_scene.add_child(new_farm_area)
			new_farm_area.init(boat)
		else:
			### Place new farm ###
			if new_farm_area.can_place:
				var farm_area = farm_area_scene.instantiate()
				get_tree().current_scene.add_child(farm_area)

				farm_area.global_position = new_farm_area.get_placement_position()
				farm_area.global_basis = new_farm_area.get_placement_basis()

				new_farm_area.queue_free()
				new_farm_area = null


func _physics_process(delta: float) -> void:
	var move_input = Input.get_axis("move_backward", "move_forward")
	var turn_input = Input.get_axis("rotate_right", "rotate_left")

	boat.move(move_input, turn_input, delta)
