extends Control

@onready var battle_pass_panel = $"../Battle Pass"

func _ready():
	battle_pass_panel.closed.connect(show)
	battle_pass_panel.hide()

func _on_battle_pass_button_pressed() -> void:
	battle_pass_panel.show()
	self.hide()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
