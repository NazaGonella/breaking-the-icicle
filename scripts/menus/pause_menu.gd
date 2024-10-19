extends Control



@onready var click : AudioStreamPlayer = $button_pressing
@onready var focus : AudioStreamPlayer = $button_switching
@onready var options_button = $PausaMargin/PausaContainer/BoonesPausa/OptionsButton


signal options_menu()
signal main_menu()

func _ready(): 
	if visible: 
		options_button.grab_focus()

func _on_options_button_pressed():
	click.play()
	options_menu.emit()
	hide()

func _on_menu_button_pressed():
	click.play()
	main_menu.emit()
	hide()

func _on_options_button_focus_entered():
	focus.play()

func _on_menu_button_focus_entered():
	focus.play()
