extends Control

@onready var start_game_button =$MarginContainer/VBoxContainer/ButtonsVBox/StartGame 

signal start_game()

signal options_menu()

func _ready(): 
	start_game_button.grab_focus()
	
func _on_start_game_pressed():
	start_game.emit()
	hide()

func _on_quit_game_button_pressed():
	get_tree().quit()

func _on_options_button_pressed():
	options_menu.emit()
	hide()
