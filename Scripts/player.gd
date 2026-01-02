extends Node3D

@export var farm_area_scene : PackedScene
@export var new_farm_area_scene : PackedScene
var new_farm_area = null

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
	else:
		### Destroy new farm if unselecting farm area ###
		if new_farm_area != null:
			_destroy_new_farm()


func _physics_process(delta: float) -> void:
	assert(state_manager != null)
	if state_manager.state != StateManager.State.RUNNING:
		return

	var move_input = Input.get_axis("move_backward", "move_forward")
	var turn_input = Input.get_axis("rotate_right", "rotate_left")

	boat.move(move_input, turn_input, delta)


func _destroy_new_farm() -> void:
	new_farm_area.queue_free()
	new_farm_area = null
