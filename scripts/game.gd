extends Node2D

@export var player : CharacterBody2D
@export var tauro : CharacterBody2D
@export var catch_timer : Timer

@export var canvas_modulate : CanvasModulate
@export var exit_lights : Node2D
@export var teleporters : Node2D
@export var soga : Node2D

@onready var kill_animation_res : SpriteFrames = preload("res://resources/kill_animation.tres")
@onready var mino_muerto_texture : Texture = preload("res://assets/mino_muerto.png")
@onready var mino_muerto_sprite_frame : SpriteFrames = preload("res://resources/minotaur_corpse.tres")

var is_player_grabbed : bool = false
var is_tauro_killed : bool = false

var faded_in : bool = false
var fade_speed : float = 2

var started_timer : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	tauro.grabbed_player.connect(grabbed_player)
	player.kill_tauro.connect(kill_tauro)
	game_playing(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not faded_in:
		player.light.energy += 0.1 * delta * fade_speed
		if player.light.energy >= 0.7:
			player.light.energy = 0.7
			faded_in = true
			game_playing(true)
		exit_lights.light_energy += 0.2 * delta * fade_speed
		if exit_lights.light_energy >= 2:
			exit_lights.light_energy = 2
			#game_playing(true)
		return
	if is_player_grabbed:
		if catch_timer.is_stopped():
			catch_timer.start()
		if is_tauro_killed:
			after_tauro_killed()
	

func _on_catched_timer_timeout():
	player.visible = false
	finish_game(false)

func after_tauro_killed():
	#set_process(false)
	catch_timer.stop()
	tauro.visible = false
	var dead_body_pos = tauro.griddedpos
	tauro.global_position = Vector2(5000, 5000)
	player.catched = false
	player.animated_sprite.visible = true
	is_player_grabbed = false
	
	# aca tendría que haber una transición
	player.light.energy = 0
	exit_lights.light_energy = 0
	canvas_modulate.color.a = 255
	faded_in = false
	game_playing(false)
	
	var mino_muerto : AnimatedSprite2D = AnimatedSprite2D.new()
	mino_muerto.sprite_frames = mino_muerto_sprite_frame
	mino_muerto.play()
	print(2 * Vector2(cos(player.rotation), sin(player.rotation)))
	#mino_muerto.global_position = player.global_position + 32 * Vector2(cos(player.rotation - PI/2), sin(player.rotation - PI/2))
	mino_muerto.global_position = (dead_body_pos * 32 ) + Vector2i(16, 16)
	#mino_muerto.global_position = player.global_position
	add_child(mino_muerto)
	move_child(mino_muerto, 2)
	
	teleporters.deactivate()
	exit_lights.activate()
	soga.remove_outer_drawings()

func finish_game(killed_tauro : bool):
	if not killed_tauro:
		set_process(false)
		# Tiempo para que se cierre el juego después de morir
		catch_timer.wait_time = 2
		catch_timer.start()
		await catch_timer.timeout
		get_tree().quit()

func kill_tauro():
	is_tauro_killed = true

func grabbed_player():
	#tauro.sprite.stop()
	#colliding_player.visible = false
	tauro.set_physics_process(false)
	player.catched = true
	player.animated_sprite.stop()
	player.animated_sprite.visible = false
	tauro.sprite.sprite_frames = kill_animation_res
	is_player_grabbed = true

func game_playing(is_playing : bool):
	player.set_physics_process(is_playing)
	tauro.set_physics_process(is_playing)
