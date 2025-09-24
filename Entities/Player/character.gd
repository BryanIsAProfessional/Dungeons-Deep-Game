extends Entity
class_name Character

signal start_minigame(minigame)
@export var minigame : Minigame = null

@export var skip_cost := 0.2
@export var defend_cost := 2.0
@export var move_cost := 2.0
@export var retreat_cost := 5.0

func _ready():
	if minigame == null: minigame = Minigame.new()
	minigame.parent = self
	super()

func _process(delta: float) -> void:
	if !is_active: return
	
	if Input.is_action_just_pressed("Skip"): skip()
	elif Input.is_action_just_pressed("Defend"): defend()
	elif Input.is_action_just_pressed("Move Forward"): move(Vector2(0,0))
	elif Input.is_action_just_pressed("Move Backward"): move(Vector2(0,0))
	elif Input.is_action_just_pressed("Move Left"): move(Vector2(0,0))
	elif Input.is_action_just_pressed("Move Right"): move(Vector2(0,0))
	elif Input.is_action_just_pressed("Retreat"): retreat()
	elif Input.is_action_just_pressed("Attack"): attack()

func skip():
	print("skip")
	is_active = false
	use_meter(skip_cost)
	turn_ended.emit()

func move(direction : Vector2):
	print("move")
	is_active = false
	use_meter(move_cost)
	turn_ended.emit()

func defend():
	print("defend")
	is_active = false
	use_meter(defend_cost)
	turn_ended.emit()

func attack():
	print("start_minigame")
	start_minigame.emit(minigame)

func retreat():
	print("retreat")
	is_active = false
	use_meter(retreat_cost)
	turn_ended.emit()

func _on_minigame_finished():
	print("_on_minigame_finished")
