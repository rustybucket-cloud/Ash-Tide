extends RigidBody3D

signal docking_area_body_entered(body: Node3D)
signal docking_area_body_exited(body: Node3D)

var bobber : Bobber

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bobber = Bobber.new()
	bobber.set_mesh($MeshInstance3D)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	bobber.bob(delta)


func _on_docking_area_body_entered(body: Node3D) -> void:
	docking_area_body_entered.emit(body)


func _on_docking_area_body_exited(body: Node3D) -> void:
	docking_area_body_exited.emit(body)
