extends Control

var prev : Control = null
@onready var volver = $MarginContainer/VBoxContainer/botones/volver

func _on_volver_pressed():
	hide()
	prev.show()
	prev.refocus()

func open_from(previo: Control): 
	prev = previo
	prev.hide()
	show()
	
func _ready(): 
	if visible: 
		volver.grab_focus()

func refocus(): 
	volver.grab_focus()


func _on_sonido_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
	
