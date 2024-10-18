extends CharacterBody2D

@export var animated_sprite : AnimatedSprite2D
@export var speed : float = 300.0

func _physics_process(delta):
	
	handle_movement()
	handle_rotation()
	handle_actions()
	
	move_and_slide()

func handle_movement():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

func handle_rotation():
	var mouse_position = get_global_mouse_position()
	rotation = atan2((global_position.x - mouse_position.x), -(global_position.y - mouse_position.y))

func handle_actions():
	if Input.is_action_just_pressed("punch"):
		animated_sprite.frame = 0
		animated_sprite.play()
		print("punch")
