extends Node3D

@export var farm_area_scene : PackedScene
var new_farm_area

@onready var boat = $Boat
@onready var detector = $Boat/TriggerDetector

var is_in_farm_area := false

func _ready() -> void:
	pass
	#detector.area_entered.connect(_on_area_entered)
	#detector.area_exited.connect(_on_area_exited)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("available_action"):
		### Place new farm area ###
		if new_farm_area != null:
			if not is_in_farm_area:
				# re-enable collisions
				for child in new_farm_area.find_children("*", "RigidBody3D", true, false):
					if child.is_in_group("Buoy"):
						child.enable_collisions()
				new_farm_area.remove_from_group("New Farm Area")
				new_farm_area = null
		### Start placing new farm area ###
		else:
			new_farm_area = farm_area_scene.instantiate()
			new_farm_area.global_position = Vector3(boat.global_position.x, 0.0, boat.global_position.z)

			# disable collisions during placement
			for child in new_farm_area.find_children("*", "RigidBody3D", true, false):
				if child.is_in_group("Buoy"):
					child.disable_collisions()

			new_farm_area.area_entered.connect(_on_area_entered)
			new_farm_area.area_exited.connect(_on_area_exited)
			
			get_tree().current_scene.add_child(new_farm_area)


func _physics_process(delta: float) -> void:
	var move_input = Input.get_axis("move_backward", "move_forward")
	var turn_input = Input.get_axis("rotate_right", "rotate_left")

	boat.move(move_input, turn_input, delta)

	if new_farm_area != null:
		new_farm_area.global_position = Vector3(boat.global_position.x, 0.0, boat.global_position.z)
		new_farm_area.global_basis = boat.global_basis


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("Farm Area"):
		area.show_occupied()
		if new_farm_area != null:
			new_farm_area.show_occupied()
		is_in_farm_area = true


func _on_area_exited(area: Area3D) -> void:
	if area.is_in_group("Farm Area"):
		area.hide_occupied()
		if new_farm_area != null:
			new_farm_area.hide_occupied()
		is_in_farm_area = false
