extends Control

@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer
@export var audio_clip_1 = preload("res://Assets/Audio/manifesto.wav")
@export var audio_clip_2 = preload("res://Assets/Audio/hah.wav")

@onready var button : TextureButton = $Control/TextureButton
@export var texture1 : Texture2D
@export var texture2 : Texture2D

var started := false
var playing_alt_audio := false
var paused_at := 0.0
@export var skipback_time := 1.0

func _ready() -> void:
	button.texture_normal = texture1
	audio_player.stream = audio_clip_1

func start():
	if !started: audio_player.play()
	started = true

func _on_texture_button_pressed() -> void:
	paused_at = audio_player.get_playback_position()
	button.texture_normal = texture2
	audio_player.stream = audio_clip_2
	audio_player.play()
	playing_alt_audio = true

func _on_audio_finished():
	if not playing_alt_audio: return
	paused_at = paused_at - skipback_time
	if paused_at < 0: paused_at = 0
	audio_player.stream = audio_clip_1
	audio_player.play(paused_at)
	playing_alt_audio = false
	button.texture_normal = texture1

func _on_active_changed(active: Variant) -> void:
	if active: start()
