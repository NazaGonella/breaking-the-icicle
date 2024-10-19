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
