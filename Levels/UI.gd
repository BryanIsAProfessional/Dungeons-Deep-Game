extends CanvasLayer

func _ready():
	hide()
	$"../GameManager".entity_active.connect(_on_entity_active)

func _on_entity_active(entity : Entity):
	if entity == null:
		hide()
		return
	if entity is Character: show()
	else: hide()
