extends Control

var prev : Control = null

func _on_volver_pressed():
	hide()
	prev.show()

func open_from(previo: Control): 
	prev = previo
	prev.hide()
	show()
	
