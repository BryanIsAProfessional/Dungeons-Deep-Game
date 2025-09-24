extends Entity
class_name Enemy

@export var hitboxes : Array[Hitbox] = []

func _ready() -> void:
	for hitbox in hitboxes:
		hitbox.hitbox_hit.connect(take_damage)
	super()

func _process(delta: float) -> void:
	if !is_active: return
	attack()
	is_active = false

func attack():
	print("Enemy is attacking")
	turn_ended.emit()
