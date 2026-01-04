extends Area3D

@export var seaweed_scene : PackedScene

signal player_entered()
signal player_exited()

@onready var occupied_mesh = $OccupiedMesh

var seaweed = null

# for when the player enters a farm area
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_entered.emit()


# for when the player exits a farm area
func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_exited.emit()


func show_occupied() -> void:
	occupied_mesh.visible = true


func hide_occupied() -> void:
	occupied_mesh.visible = false


func show_seaweed() -> void:
	assert(seaweed == null)
	var seaweed_count = randi_range(15, 25)
	var size = $CollisionShape3D.shape.size
	seaweed = []
	for i in range(seaweed_count):
		var seaweed_position = Vector3(
			randf_range(-size.x/2, size.x/2),
			0,
			randf_range(-size.z/2, size.z/2)
		)
		var seaweed_item = seaweed_scene.instantiate()
		add_child(seaweed_item)
		seaweed_item.position = seaweed_position
		seaweed.append(seaweed_item)


func remove_seaweed() -> void:
	assert(seaweed != null)

	for item in seaweed:
		item.queue_free()
	seaweed = null


func show_buoy_red() -> void:
	pass


func hide_buoy_red() -> void:
	pass
