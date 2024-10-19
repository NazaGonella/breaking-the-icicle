extends CharacterBody2D

@export var animated_sprite : AnimatedSprite2D
@export var campo_de_vision : Sprite2D

const SPEED : float = 30.0
#
#func _ready():
	#campo_de_vision.visible = true

func _physics_process(delta):
	var velocity_length = handle_movement()
	if velocity_length != 0:
		handle_rotation()
	handle_actions()
	move_and_slide()

func handle_movement():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	return velocity.length()

func handle_rotation():
	rotation = atan2((velocity.x), -(velocity.y))

func handle_actions():
	if Input.is_action_just_pressed("punch"):
		animated_sprite.frame = 0
		animated_sprite.play()

