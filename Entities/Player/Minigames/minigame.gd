extends Node
class_name Minigame

@export var display_name = ""
var target : Entity = null
var parent : Entity = null
var is_active := false
signal finished

func _ready():
	name = display_name

func start(new_target):
	print("starting %s's minigame: %s" % [parent.name, display_name])
	target = new_target
	is_active = true
	setup()

func setup():
	print("using the generic minigame")
	await get_tree().create_timer(1.5).timeout
	finish()

func cancel():
	is_active = false
	print("cancelling %s's minigame" % parent.name)
	finished.emit()

func finish():
	is_active = false
	print("ending %s's minigame" % parent.name)
	finished.emit()
