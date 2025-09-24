extends PointOfInterest

@onready var nose_clicker = $"Sprite3D/SubViewport/Nose Clicker"

func _process(delta: float) -> void:
	if is_active:
		if Input.is_action_just_pressed("ui_accept"):
			nose_clicker._on_texture_button_pressed()
