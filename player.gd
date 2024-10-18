extends CharacterBody2D

@export var animated_sprite : AnimatedSprite2D
@export var punch_area : Area2D
@export var punch_cooldown : Timer

const SPEED : float = 80.0
const ROTATION_SPEED : float = 3.0

func _physics_process(delta):
	var velocity_length = handle_movement()
	if velocity_length != 0:
		handle_rotation()
	handle_actions()
	
	move_and_slide()

func handle_movement():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	#var direction = Input.get_axis("move_up", "move_down")
	if direction:
		velocity = direction * SPEED
		#velocity = direction * orientation * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	return velocity.length()

func handle_rotation():
	#var direction = Input.get_axis("rotate_left", "rotate_right")
	rotation = atan2((velocity.x), -(velocity.y))

func handle_actions():
	if Input.is_action_just_pressed("punch"):
		animated_sprite.frame = 0
		animated_sprite.play()
		punch_action()

func punch_action():
	for body in punch_area.get_overlapping_bodies():
		print("Punched ", body)

