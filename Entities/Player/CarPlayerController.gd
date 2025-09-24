extends VehicleBody3D
class_name PlayerVehicle

@onready var camera : Camera3D = $CamPos/Camera3D
@export var max_steer = 0.9
@export var engine_power = 300
@export var cam_position_target : Node3D = null
var default_camera_position = Transform3D.IDENTITY
var camera_target : Node3D = null
var lerp_speed = 0.1

func _process(delta: float) -> void:
	if camera_target:
		camera.transform = camera.transform.interpolate_with(camera.transform.looking_at(camera_target.global_position, Vector3(0,1,0), true), lerp_speed)
	else:
		camera.transform = camera.transform.interpolate_with(default_camera_position, lerp_speed)

func _physics_process(delta: float) -> void:
	steering = move_toward(steering, Input.get_axis("Turn Right", "Turn Left") * max_steer, delta)
	engine_force = Input.get_axis("Brake", "Accelerate") * engine_power
