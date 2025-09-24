extends MeshInstance3D

@export var shrink_speed := .3

func _process(delta: float) -> void:
	scale.x -= clampf(shrink_speed, .01, INF) * delta
	scale.z -= clampf(shrink_speed, .01, INF) * delta
