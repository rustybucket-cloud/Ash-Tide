extends RigidBody3D

var bobber


func _ready() -> void:
	bobber = Bobber.new()
	bobber.set_mesh($MeshInstance3D)


func _physics_process(delta: float) -> void:
	bobber.bob(delta)
	

func disable_collisions() -> void:
	$CollisionShape3D.disabled = true
	

func enable_collisions() -> void:
	$CollisionShape3D.disabled = false
