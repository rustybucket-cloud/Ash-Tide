extends Node3D

@export var farm_area_scene : PackedScene
@export var new_farm_area_scene : PackedScene
var new_farm_area = null

@export var seed_planter_scene : PackedScene
var seed_planter = null

@onready var boat = $Boat
@onready var detector = $Boat/TriggerDetector

var is_new_farm_placement_disabled := false
var state_manager : StateManager

func set_state_manager(sm : StateManager) -> void:
	state_manager = sm


func _process(_delta: float) -> void:
	assert(state_manager != null)
	if state_manager.state != StateManager.State.RUNNING:
		return

	var selected_item = Inventory.get_selected_item()
	
	### Place farm area when selecting farm area ###
	if selected_item != null and selected_item.display_name == "Farm Area":
		if new_farm_area == null:
			### Start new farm placement ###
			new_farm_area = new_farm_area_scene.instantiate()
			get_tree().current_scene.add_child(new_farm_area)
			new_farm_area.init(boat)
		else:
			if Input.is_action_just_pressed("available_action"):
				### Place new farm ###
				if new_farm_area.can_place:
					var farm_area = farm_area_scene.instantiate()
					get_tree().current_scene.add_child(farm_area)

					farm_area.global_position = new_farm_area.get_placement_position()
					farm_area.global_basis = new_farm_area.get_placement_basis()

					_destroy_new_farm()
					Inventory.remove_selected_item()
	else:
		### Destroy new farm if unselecting farm area ###
		if new_farm_area != null:
			_destroy_new_farm()
	
	if selected_item != null and selected_item.display_name == "Seaweed Seed":
		if seed_planter == null:
			seed_planter = seed_planter_scene.instantiate()
			seed_planter.init(boat)
			get_tree().current_scene.add_child(seed_planter)
		else:
			if Input.is_action_just_pressed("available_action"):
				if seed_planter.can_plant():
					seed_planter.plant()
					Inventory.remove_selected_item()
	else:
		if seed_planter != null:
			_destroy_seed_planter()


func _physics_process(delta: float) -> void:
	assert(state_manager != null)
	if state_manager.state != StateManager.State.RUNNING:
		return

	var move_input = Input.get_axis("move_backward", "move_forward")
	var turn_input = Input.get_axis("rotate_right", "rotate_left")

	boat.move(move_input, turn_input, delta)


func _destroy_new_farm() -> void:
	assert(new_farm_area != null)
	new_farm_area.queue_free()
	new_farm_area = null


func _destroy_seed_planter() -> void:
	assert(seed_planter != null)
	seed_planter.queue_free()
	seed_planter = null


func _on_boat_area_entered(area: Area3D) -> void:
	if seed_planter != null:
		seed_planter.entered_farm_area(area)


func _on_boat_area_exited(area: Area3D) -> void:
	if seed_planter != null:
		seed_planter.exited_farm_area(area)
