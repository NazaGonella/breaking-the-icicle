extends Node2D

@export var exit : Area2D

func activate():
	visible = true
	exit.monitoring = true
	exit.monitorable = true


func _on_exit_body_entered(body):
	if body.name == "Player":
		print("ESCAPASTE")
