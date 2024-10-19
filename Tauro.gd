extends CharacterBody2D

var griddedhistory : Array = [Vector2i(0,0)]
var griddedpos: Vector2i = Vector2i(0,0)

func _physics_process(delta):
	global_position=get_global_mouse_position()
	griddedpos= Vector2i(global_position.x/32,global_position.y/32)
	if griddedpos!=griddedhistory[-1]:
		griddedhistory.append(griddedpos)
	velocity.y = 100
	velocity.x = 100
	
	move_and_slide()
