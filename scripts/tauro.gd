extends CharacterBody2D

var CHASING : bool = false
var griddedpos: Vector2i = Vector2i(0,0)

@onready var kill_animation_res : SpriteFrames = preload("res://kill_animation.tres")

@export var sprite : AnimatedSprite2D
@export var rotated_tauro : Node2D
@export var patrulla_component : Node2D
@export var raycasts : Node2D

var temp_vel = Vector2.ZERO
var playing_animation : bool = false

var colliding_player : CharacterBody2D = null

const SPEED = 30.0
const CHASE_SPEED = 100.0

func _physics_process(delta):
	#print(sprite.is_playing())
	griddedpos= Vector2i(global_position.x/32,global_position.y/32)
	#print(sprite.frame)
	if not check_for_player():
		reproducir_sonidos()
		check_for_chase()
		handle_movement()
		handle_animation()

func check_for_player():
	if colliding_player:
		#colliding_player.velocity = Vector2.ZERO
		velocity = Vector2.ZERO
		sprite.stop()
		#colliding_player.visible = false
		colliding_player.catched = true
		colliding_player.animated_sprite.stop()
		colliding_player.visible = false
		sprite.sprite_frames = kill_animation_res
		sprite.play()
		return true
	return false

func check_for_chase():
	for r in raycasts.get_children():
		if r.is_colliding():
			if r.get_collider().name == "Player":
				if not CHASING:
					temp_vel = (r.get_collider().global_position - global_position).normalized() * CHASE_SPEED
				CHASING = true

func reproducir_sonidos():
	# checkear si velocity.length != 0 y reproducir sonido de pisadas
	# si CHASING == true reproducir rugido y pisadas más rápido
	pass

func handle_movement():
	if CHASING:
		if abs(temp_vel.x) > abs(temp_vel.y):
			temp_vel.y = 0
		else:
			temp_vel.x = 0
		velocity = temp_vel
		move_and_slide()
	if CHASING and velocity.length() < 1:
		CHASING = false
		patrulla_component._tauro_crash()
	if not patrulla_component.WAITING and not CHASING:
		#print("patrolling")
		velocity = patrulla_component.direction * SPEED
		move_and_slide()

func handle_animation():
	if patrulla_component.WAITING:
		sprite.stop()
	elif not playing_animation:
		sprite.play()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		colliding_player = body
	
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		colliding_player = null
