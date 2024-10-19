extends CharacterBody2D

var griddedpos: Vector2i = Vector2i(0,0)

func _physics_process(delta):
	global_position=get_global_mouse_position()
	griddedpos= Vector2i(global_position.x/64,global_position.y/64)
	#print(griddedpos)
	velocity.y = 100
	velocity.x = 100
	
	move_and_slide()
