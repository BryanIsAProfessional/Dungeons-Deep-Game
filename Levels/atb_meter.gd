extends Sprite3D

@onready var target : Entity = null
@onready var timer : Timer = $"../Timer"
@onready var health_bar : ProgressBar = $SubViewport/VBoxContainer/HealthBar
@onready var atb_bar : ProgressBar = $SubViewport/VBoxContainer/ATBBar

func _ready() -> void:
	if get_parent() is Entity:
		target = get_parent()
	if target != null:
		target.health_changed.connect(_on_health_changed)
		health_bar.max_value = target.max_health
		health_bar.value = target.health
	else: print("Target was null")

func _process(delta: float) -> void:
	if timer == null or atb_bar == null or target == null or health_bar == null: return
	var p = (timer.wait_time - timer.time_left) / timer.wait_time
	var percent = p * 100
	atb_bar.value = percent

func _on_health_changed(old, new):
	health_bar.value = new
