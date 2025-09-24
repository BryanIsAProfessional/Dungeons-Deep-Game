extends Minigame

#@onready var prefab = preload("res://Entities/Player/Minigames/Ranger/RangerMinigame.tscn")
@export var damage_amount := 20
var obj = null
@onready var cam = $"../RangerCamera"
@onready var raycast : RayCast3D = $"../RangerCamera/RayCast3D"
@onready var audio_stream = $"../AudioStreamPlayer"
@export var move_amount := 0.001

func _process(delta: float) -> void:
	if !is_active: return
	if Input.is_action_just_released("Mouse Click"): shoot()

func _input(event: InputEvent) -> void:
	if !is_active: return
	if event is InputEventMouseMotion:
		move(event.relative)

func move(mv : Vector2):
	parent.position += Vector3(0, mv[1] * move_amount, mv[0] * move_amount)

func shoot():
	var hitbox = get_raycast_result()
	if hitbox is Hitbox: hitbox.hit(damage_amount)
	finish()

func get_raycast_result():
	var result = null
	if raycast.is_colliding():
		result = raycast.get_collider()
	return result

#func _ready() -> void:
	#obj = prefab.instantiate()
	#add_child(obj)
	#obj.shoot_arrow.connect(finish)

func setup():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	audio_stream.play()
	cam.set_current(true)
	#obj.start()

func finish():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	parent.position = Vector3(0,0,0)
	cam.set_current(false)
	target.take_damage(damage_amount)
	super()
