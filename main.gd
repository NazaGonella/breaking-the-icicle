extends Node2D

@export var player : CharacterBody2D
@export var tauro : CharacterBody2D
@export var catch_timer : Timer

@onready var kill_animation_res : SpriteFrames = preload("res://kill_animation.tres")

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
	#print(catch_timer.time_left)
	#print("pos: ", player.global_position)
	#print(catch_timer.time_left)
	if not faded_in:
		player.light.energy += 0.1 * delta * fade_speed
		if player.light.energy >= 0.7:
			player.light.energy = 0.7
			faded_in = true
			game_playing(true)
		return
	if is_player_grabbed:
		if catch_timer.is_stopped():
			catch_timer.wait_time = 3
			catch_timer.start()
		if is_tauro_killed:
			catch_timer.stop()
			var old_tau_pos = tauro.global_position
			tauro.visible = false
			tauro.global_position = Vector2(5000, 5000)
			#player.global_position = old_tau_pos
			player.catched = false
			player.animated_sprite.visible = true
			is_player_grabbed = false

func _on_catched_timer_timeout():
	player.visible = false
	finish_game(false)

func finish_game(killed_tauro : bool):
	if not killed_tauro:
		set_process(false)
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
