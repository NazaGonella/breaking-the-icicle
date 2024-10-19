extends CharacterBody2D

@export var animated_sprite : AnimatedSprite2D
@export var mano:Marker2D

var spriteOvillo = preload("res://assets/player.png")
var spriteCuchillo= preload("res://assets/player.png")

const SPEED : float = 80.0

var griddedhistory : Array = []
var globalhistory : Array = []
var tphistory: Array = []
var griddedpos: Vector2i

var drawNow: bool = false
var justTped: bool = false

var canSwitch: bool = true
var hasOvillo: bool = true

func _physics_process(delta):
	drawNow=false
	griddedpos= Vector2i(global_position.x/32,global_position.y/32)
	
	if hasOvillo:
		if griddedhistory.size()==0 or griddedpos!=griddedhistory[-1]:
			griddedhistory.append(griddedpos)
			#print(griddedhistory)
		if globalhistory.size()==0 or global_position.distance_to(globalhistory[-1])>=8 :
			globalhistory.append(mano.global_position)
			#print(mano.global_position)
			drawNow=true
	if canSwitch and Input.is_action_just_pressed("f"):
		if hasOvillo:
			hasOvillo=false
			$Sprite.texture=spriteCuchillo
		else:
			hasOvillo=true
			$Sprite.texture=spriteCuchillo
			
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

func _on_espada_body_entered(body):
	canSwitch=true


func _on_espada_body_exited(body):
	canSwitch=false
