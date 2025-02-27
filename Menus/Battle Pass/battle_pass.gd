@tool
extends Control

var battle_pass_item_prefab = preload("res://Menus/Battle Pass/battle_pass_item_prefab.tscn")
@onready var items_container = $"ScrollContainer/Items Container"

@export var battle_pass_items : Array[BattlePassItem] = []

signal closed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for item in battle_pass_items:
		var node : BattlePassItemNode = battle_pass_item_prefab.instantiate()
		items_container.add_child(node)
		node.set_content(item)

func close():
	self.visible = false
	closed.emit()

func _on_button_pressed() -> void:
	close()
