extends CharacterBody2D


@export var speed : float = 300.0

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	
	var mouse_position = get_global_mouse_position()
	rotation = atan2((global_position.x - mouse_position.x), -(global_position.y - mouse_position.y))
	print(rotation)
	
	move_and_slide()
