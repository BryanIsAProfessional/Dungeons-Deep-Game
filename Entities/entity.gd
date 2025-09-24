extends Node3D
class_name Entity

signal atb_full(entity)
signal health_changed(old, new)
signal turn_ended
signal died

var is_alive := true
var is_charging := false
var is_active := false
@onready var timer : Timer = $Timer
@export var atb_charge_time := 3.0

var health := 100:
	set(value):
		var old_health = health
		health = value
		health_changed.emit(old_health, health)
		if health <= 0:
			die()
@export var max_health := 100

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = atb_charge_time
	timer.one_shot = true

func set_active(active):
	is_charging = active and is_alive
	if active:
		timer.paused = false
		timer.start()
	else: timer.paused = true

func take_damage(amount):
	health -= amount

func die():
	is_alive = false
	rotate_z(-90)
	died.emit()

func _on_timer_timeout():
	atb_full.emit(self)

func use_meter(meter := -1.0):
	if meter < 0 or meter > atb_charge_time: timer.start()
	else: timer.start(atb_charge_time - meter)
