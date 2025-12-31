extends Area3D

signal player_entered()
signal player_exited()

@onready var occupied_mesh = $OccupiedMesh


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_entered.emit()


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_exited.emit()


func show_occupied() -> void:
	occupied_mesh.visible = true


func hide_occupied() -> void:
	occupied_mesh.visible = false


func show_buoy_red() -> void:
	pass


func hide_buoy_red() -> void:
	pass
