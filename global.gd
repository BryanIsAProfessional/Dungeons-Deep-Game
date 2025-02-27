extends Node

var global_audio_player := AudioStreamPlayer.new()

func _ready() -> void:
	self.add_child(global_audio_player)

func play_audio(audio : AudioStream):
	global_audio_player.stream = audio
	global_audio_player.play(0)
