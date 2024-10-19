extends Control


@onready var click : AudioStreamPlayer = $button_pressing
@onready var focus : AudioStreamPlayer = $button_switching
@onready var options_button = $PausaMargin/PausaContainer/Botones/Opciones

signal options_menu()
signal main_menu()

func _ready():
	if visible: 
		options_button.grab_focus()

func _on_opciones_pressed():
	click.play()
	options_menu.emit()
	hide()

func _on_menu_pressed():
	main_menu.emit()
	hide()

func _on_opciones_focus_entered():
	focus.play()

func _on_menu_focus_entered():
	focus.play()
