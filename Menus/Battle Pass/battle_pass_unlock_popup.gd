extends Control
class_name UnlockPopup

@onready var item_label : Label = $"Item Name"
@onready var icon : TextureRect = $Icon
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var button : Button = $Button
@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var sound_effects : Array[AudioStream] = []

func _ready() -> void:
	anim_player.play("wipe_in")
	

func enable():
	button.disabled = false

func set_item(item : BattlePassItem):
	item_label.text = item.display_name
	icon.texture = item.icon
	if sound_effects.size() > item.rarity: Global.play_audio(sound_effects[item.rarity])

func _on_button_pressed() -> void:
	start_close_panel()

func start_close_panel():
	anim_player.play("wipe_out")

func close_panel():
	queue_free()
