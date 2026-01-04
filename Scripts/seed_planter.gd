extends MeshInstance3D

@export var boat_offset := Vector3(1, 1, 1)
@export var transparent_color = "#04040472"
@export var hovered_color = "#0505059e"

var boat : Node3D

var _hovered_farm_area : Area3D = null

func init(b : Node3D) -> void:
	boat = b


func can_plant() -> bool:
	return _hovered_farm_area != null


func _process(delta: float) -> void:
	# change the transparency depending on if the seed can be planted
	var material = get_surface_override_material(0)
	if can_plant():
		material.albedo_color = hovered_color
	else:
		material.albedo_color = transparent_color
	set_surface_override_material(0, material)


func _physics_process(delta: float) -> void:
	if boat == null:
		return
	
	# follow the boat
	global_basis = boat.global_basis
	global_position = boat.global_position + boat.global_basis * boat_offset


func entered_farm_area(farm_area: Area3D) -> void:
	if farm_area.is_in_group("Farm Area"):
		_hovered_farm_area = farm_area


func exited_farm_area(farm_area: Area3D) -> void:
	if farm_area.is_in_group("Farm Area"):
		_hovered_farm_area = null


func plant() -> void:
	if !can_plant():
		return
	
	_hovered_farm_area.show_seaweed()
