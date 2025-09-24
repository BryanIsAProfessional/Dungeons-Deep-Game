extends Node

enum game_state {}

@export var players : Array[Character] = []
@export var enemies : Array[Enemy] = []

signal entity_active(entity)

var active_entity : Entity = null
var action_queue : Array[Entity] = []
var is_in_minigame := false
var paused := true:
	set(value):
		paused = value
		for player in players:
			player.set_active(!paused)
		for enemy in enemies:
			enemy.set_active(!paused)
var target : Enemy = null

func _ready() -> void:
	for player in players:
		player.atb_full.connect(_on_atb_full)
		player.turn_ended.connect(_on_turn_ended)
		player.health = player.max_health
		player.died.connect(_on_player_died)
		player.start_minigame.connect(_on_minigame_started)
		player.minigame.finished.connect(_on_minigame_finished)
	for enemy in enemies:
		if target == null: target = enemy
		enemy.atb_full.connect(_on_priority_atb_full)
		enemy.turn_ended.connect(_on_turn_ended)
		enemy.health = enemy.max_health
		enemy.died.connect(_on_enemy_died)
		#enemy.start_minigame.connect(_on_minigame_started)
		#enemy.minigame.finished.connect(_on_minigame_finished)
	start_encounter()

func _process(delta: float) -> void:
	if !paused and !is_in_minigame and action_queue.size() > 0:
		active_entity = action_queue.pop_front()
		if active_entity != null:
			entity_active.emit(active_entity)
			active_entity.is_active = true

func start_encounter():
	for player in players:
		player.set_active(true)
	for enemy in enemies:
		enemy.set_active(true)
	paused = false

func end_encounter(won : bool):
	paused = true
	var ret = "Won" if won else "Lost"
	print("%s the encounter" % ret)

func _on_minigame_started(minigame : Minigame):
	start_minigame(minigame)

func start_minigame(minigame : Minigame):
	if minigame == null:
		print("tried to start a minigame that was null")
		return
	if active_entity == null:
		print("active entity shouldn't be null")
		return
	is_in_minigame = true
	minigame.start(target)

func _on_turn_ended():
	active_entity = null
	is_in_minigame = false

func _on_minigame_finished():
	active_entity.use_meter()
	active_entity.turn_ended.emit()

func _on_atb_full(entity):
	print("%s is ready to move" % entity.name)
	action_queue.append(entity)

func _on_priority_atb_full(entity):
	print("%s is ready to move" % entity.name)
	action_queue.push_front(entity)

func _on_player_died():
	var all_died := true
	for player in players:
		if player.is_alive:
			all_died = false
			break
	
	if all_died: end_encounter(false)

func _on_enemy_died():
	var all_died := true
	for enemy in enemies:
		if enemy.is_alive:
			all_died = false
			break
	
	if all_died: end_encounter(true)
