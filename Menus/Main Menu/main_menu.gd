extends Control

@export var nose_clicker_path = "res://nose_clicker.tscn"
@export var car_world_path = "res://Levels/car_world.tscn"
@onready var battle_pass_panel = $"../Battle Pass"

func _ready():
	battle_pass_panel.closed.connect(show)
	battle_pass_panel.hide()

func _on_start_game_button_pressed() -> void:
	Global.open_scene(car_world_path)
	self.queue_free()

func _on_battle_pass_button_pressed() -> void:
	battle_pass_panel.show()
	self.hide()

func _on_nose_clicker_button_pressed() -> void:
	Global.open_scene(nose_clicker_path)
	self.hide()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
