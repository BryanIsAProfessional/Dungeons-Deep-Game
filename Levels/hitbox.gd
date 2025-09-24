extends Area3D
class_name Hitbox

signal hitbox_hit(amount)

func hit(amount):
	hitbox_hit.emit(amount)
