extends Control

@onready var start_game_button =$MarginContainer/VBoxContainer/ButtonsVBox/StartGame 
@onready var click = $button_pressing
@onready var focus = $button_switching

signal start_game()

signal options_menu()

func _ready(): 
	start_game_button.grab_focus()
	
func _on_start_game_pressed():
	click.play()
	start_game.emit()
	hide()

func _on_quit_game_button_pressed():
	click.play()
	get_tree().quit()

func _on_options_button_pressed():
	click.play()
	options_menu.emit()
	hide()

func _on_start_game_focus_entered():
	focus.play()

func _on_options_button_focus_entered():
	focus.play()

func _on_quit_game_button_focus_entered():
	focus.play()


func _on_start_game_mouse_entered():
	focus.play()

func _on_options_button_mouse_entered():
	focus.play()

func _on_quit_game_button_mouse_entered():
	focus.play()
