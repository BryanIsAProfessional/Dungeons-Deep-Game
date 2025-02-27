@tool
extends Control
class_name BattlePassItemNode

var unlock_popup = preload("res://Menus/Battle Pass/battle_pass_unlock_popup.tscn")
@onready var icon : TextureButton = $Icon
@onready var overlay : TextureRect = $Overlay
var unlockable := true:
	set(value):
		if unlocked: unlockable = false
		else: unlockable = value
		toggle_unlockable(unlockable)
@export var locked_tint := Color.DIM_GRAY
@export var unlocked_tint := Color.GRAY
@export var rarity_overlays : Array[Texture2D] = []
var unlocked := false
var item_content = null

func _ready() -> void:
	toggle_unlockable(unlockable)
	if unlocked: set_unlocked()

func set_content(item : BattlePassItem):
	item_content = item
	name = item.display_name
	icon.texture_normal = item.icon
	overlay.texture = rarity_overlays[item.rarity]

func toggle_unlockable(value : bool):
	if value: icon.modulate = Color.WHITE
	else: icon.modulate = locked_tint

func set_unlocked():
	unlocked = true
	icon.modulate = unlocked_tint
	icon.disabled = true

func unlock():
	var popup = unlock_popup.instantiate()
	get_tree().root.add_child(popup)
	popup.set_item(item_content)
	set_unlocked()

func _on_icon_pressed() -> void:
	if unlockable: unlock()
