extends CharacterBody2D
@export var animated_sprite : AnimatedSprite2D
@export var punch_area : Area2D
@export var punch_cooldown : Timer

const SPEED : float = 80.0
const ROTATION_SPEED : float = 3.0

var griddedhistory : Array = []
var globalhistory : Array = []
var griddedpos: Vector2i

var drawNow: bool = false

func _physics_process(delta):
	print(globalhistory)
	drawNow=false
	var velocity_length = handle_movement()
	if velocity_length != 0:
		handle_rotation()
	handle_actions()
	
	griddedpos= Vector2i(global_position.x/64,global_position.y/64)
	#print(griddedpos)
	if griddedhistory.size()==0 or griddedpos!=griddedhistory[-1]:
		griddedhistory.append(griddedpos)
		#print(griddedhistory)
	if globalhistory.size()==0 or global_position.distance_to(globalhistory[-1])>=20:
		globalhistory.append(global_position)
		drawNow=true
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
		
