extends CharacterBody2D

signal grabbed_player

var CHASING : bool = false
var griddedpos: Vector2i = Vector2i(0,0)

@export var sound : AudioStreamPlayer2D
@export var instant_sound : AudioStreamPlayer2D
@export var sprite : AnimatedSprite2D
@export var rotated_tauro : Node2D
@export var patrulla_component : Node2D
@export var raycasts : Node2D
var is_playing_embestida : bool = false

var embestida_sound = preload("res://assets/sounds2/tauro_embestida.ogg")
var patrulla_sound = preload("res://assets/sounds2/robot-heavy-mechanical-footsteps-194039.mp3")
var choque_sound = preload("res://assets/sounds2/thud2.mp3")

var temp_vel = Vector2.ZERO
var playing_animation : bool = false

var colliding_player : CharacterBody2D = null

#const SPEED = 45.0
const SPEED = 55.0
#const SPEED = 200
const CHASE_SPEED = 100.0

func _physics_process(delta):
	#print(reaction_timer.time_left)
	griddedpos= Vector2i(global_position.x/32,global_position.y/32)
	if not check_for_player():
		check_for_chase()
		handle_movement()
		handle_animation()

func check_for_player():
	if colliding_player:
		grabbed_player.emit()
		return true
	return false

func check_for_chase():
	for r in raycasts.get_children():
		if r.is_colliding():
			if r.get_collider().name == "Player":
				start_chase((r.get_collider().global_position - global_position).normalized())

func start_chase(direction):
	#if not CHASING:
		#temp_vel = direction * CHASE_SPEED
	CHASING = true
	#if reaction_timer.is_stopped():
		#reaction_timer.start()
	#await reaction_timer.timeout
	temp_vel = direction * CHASE_SPEED

func handle_movement():
	if CHASING:
		if not is_playing_embestida:
			#sonido.stream = embestida_sound
			#sonido.playing = true
			change_sonido_to(embestida_sound)
			is_playing_embestida = true
		if abs(temp_vel.x) > abs(temp_vel.y):
			temp_vel.y = 0
		else:
			temp_vel.x = 0
		velocity = temp_vel
		move_and_slide()
	if CHASING and velocity.length() < 1:
		play_sound(choque_sound)
		is_playing_embestida = false
		#sonido.stream = patrulla_sound
		#sonido.playing = true
		#if not is_playing_patrulla:
		change_sonido_to(patrulla_sound)
		#is_playing_patrulla = true
		CHASING = false
		patrulla_component._tauro_crash()
	if not patrulla_component.WAITING and not CHASING:
		#print("patrolling")
		#sonido.stream = null
		if sound.playing == false:
			change_sonido_to(patrulla_sound)
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

func change_sonido_to(new_sonido, play : bool = true):
	#var sonidos_c = sonidos.get_children()
	sound.stream = new_sonido
	sound.playing = true

func play_sound(new_sound):
	instant_sound.stream = new_sound
	instant_sound.play()
