extends CharacterBody2D

@export var animated_sprite : AnimatedSprite2D
@export var mano : Marker2D
@export var light : PointLight2D

signal grab_item
signal kill_tauro

var playing_animation : bool = false
#const SPEED : float = 30.0
const SPEED : float = 150.0

@export var sound : AudioStreamPlayer2D
#@onready var kill_action = $CanvasLayer/killAction

var walking_sound = preload("res://assets/sounds2/teseo.mp3")
var slash2_sound = preload("res://assets/sounds2/pickupsword.mp3")
var soga_sound = preload("res://assets/sounds2/lana.ogg")

var catched : bool = false

var CHOPEO_SOGA : int = 10
var griddedhistory : Array = []
var globalhistory : Array = []
var tphistory: Array = []
var griddedpos: Vector2i
var drawNow: bool = false
var canSwitch: bool = false
var hasOvillo: bool = true

func _physics_process(delta):
	#print(hasOvillo)
	#if velocity != Vector2.ZERO:
		#if sound.playing == false:
			#sound.stream = walking_sound
			#sound.play()
	#else:
		#sound.stream = null
	colocar_ovillo()
	if not catched:
		var velocity_length = handle_movement()
		if velocity_length != 0:
			handle_rotation()
		handle_animations()
		move_and_slide()
	elif not hasOvillo:
		#kill_action.visible = true
		if Input.is_action_just_pressed("Kill"):
			_kill_tauro()

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

func handle_animations():
	if not playing_animation and velocity.length() != 0:
		animated_sprite.play()
		playing_animation = true
	if velocity.length() == 0:
		animated_sprite.stop()
		animated_sprite.frame = 0
		playing_animation = false

func colocar_ovillo():
	drawNow=false
	griddedpos= Vector2i(global_position.x/32,global_position.y/32)
	
	if hasOvillo:
		if griddedhistory.size()==0 or griddedpos!=griddedhistory[-1]:
			griddedhistory.append(griddedpos)
			#print(griddedhistory)
		if globalhistory.size()==0 or global_position.distance_to(globalhistory[-1])>=CHOPEO_SOGA:
			globalhistory.append(mano.global_position)
			#print(mano.global_position)
			drawNow=true
	#else:
		#drawNow=true
	if canSwitch and Input.is_action_just_pressed("interactuar"):
		if hasOvillo:
			get_parent().play_sound(slash2_sound)
			hasOvillo=false
			animated_sprite.animation="alt"
			grab_item.emit()
		else:
			hasOvillo=true
			animated_sprite.animation="default"
			get_parent().play_sound(soga_sound)
			grab_item.emit()

func _kill_tauro():
	kill_tauro.emit()

#func show_kill_action():
	#kill_action.show
	
#func hide_kill_action():
	#kill_action.hide()
