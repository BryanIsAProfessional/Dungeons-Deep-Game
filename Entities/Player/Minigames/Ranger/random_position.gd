extends Control
signal shoot_arrow

@onready var button = $ShootArrowButton
var is_active := false:
	set(value):
		is_active = value
		if is_active:
			button.disabled = false
			show()
		else:
			button.disabled = true
			hide()

func _ready() -> void:
	is_active = false

func start():
	var new_pos = Vector2(randi_range(200, 1200), randi_range(200, 800))
	button.set_position(new_pos)
	is_active = true

func _on_shoot_arrow_button_pressed() -> void:
	shoot_arrow.emit()
	is_active = false
