extends Area3D
class_name PointOfInterest

signal player_entered(player)
signal player_exited(player)
signal active_changed(active)

@export var camera_target : Node3D = null
var is_active := false:
	set(value):
		is_active = value
		active_changed.emit(is_active)

func _on_body_entered(body: Node3D) -> void:
	if body is PlayerVehicle:
		var player : PlayerVehicle = body
		if camera_target != null: player.camera_target = camera_target
		player_entered.emit(player)
		is_active = true

func _on_body_exited(body: Node3D) -> void:
	if body is PlayerVehicle:
		var player : PlayerVehicle = body
		if camera_target != null: player.camera_target = null
		player_exited.emit(player)
		is_active = false
