extends Node3D

var farm_area

var boat : Node3D

var can_place := true

func init(new_boat: Node3D) -> void:
	boat = new_boat
	farm_area = get_node("Farm Area")
	_sync_boat_and_farm_area()
	
	for child in farm_area.find_children("*", "RigidBody3D", true, false):
		if child.is_in_group("Buoy"):
			child.disable_collisions()
	
	farm_area.area_entered.connect(_on_area_entered)
	farm_area.area_exited.connect(_on_area_exited)
	
	farm_area.body_entered.connect(_on_body_entered)
	farm_area.body_exited.connect(_on_body_exited)


func get_placement_position() -> Vector3:
	return farm_area.global_position


func get_placement_basis() -> Basis:
	return farm_area.global_basis


func _physics_process(_delta: float) -> void:
	_sync_boat_and_farm_area()

func _sync_boat_and_farm_area() -> void:
	assert(boat != null, "boat must be defined in new_farm_area")
	assert(farm_area != null, "farm_area must be defined in new_farm_area")
	farm_area.global_position = boat.global_position
	farm_area.global_basis = boat.global_basis


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("Farm Area"):
		area.show_occupied()
		_disable_new_farm_placement()


func _on_area_exited(area: Area3D) -> void:
	if area.is_in_group("Farm Area"):
		area.hide_occupied()
		_enable_new_farm_placement()


# disables placing new farm area when object is inside new farm area
func _on_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Dock"):
		return
	_disable_new_farm_placement()


func _on_body_exited(body: Node3D) -> void:
	if not body.is_in_group("Dock"):
		return
	_enable_new_farm_placement()


func _enable_new_farm_placement() -> void:
	farm_area.hide_occupied()
	can_place = true


func _disable_new_farm_placement() -> void:
	farm_area.show_occupied()
	can_place = false
