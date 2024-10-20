extends Node2D

@export var exit : Area2D
@export var lights : Node2D

var light_energy : float = 2

func _process(delta):
	for light in lights.get_children():
		light.energy = light_energy

func activate():
	visible = true
	exit.monitoring = true
	exit.monitorable = true



func _on_exit_body_entered(body):
	if body.name == "Player":
		print("ESCAPASTE")
