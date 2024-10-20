extends Control


@onready var start_game_button = $ColorRect2/MarginContainer/VBoxContainer/ButtonsVBox/StartGame

signal start_game()

func _ready(): 
	start_game_button.grab_focus()
	
func _on_start_game_pressed():
	start_game.emit()
	hide()

func _on_quit_game_button_pressed():
	get_tree().quit()

func _on_options_button_pressed():
	pass
