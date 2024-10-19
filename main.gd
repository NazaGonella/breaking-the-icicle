extends Node2D

@onready var main_menu: Control = $MainMenu
@onready var game_scene : Node2D = $GameScene
@onready var camera : Camera2D = $Camera2D
@onready var options_menu : Control = $OptionsMenu
@onready var pause_menu : Control = $PauseMenu


var paused : bool = false

func _ready():
	main_menu.start_game.connect(game_started)
	main_menu.options_menu.connect(options_menu_opened)
	pause_menu.options_menu.connect(options_menu_opened)
	main_menu.visible = true
	camera.visible = false
	pause_menu.visible = false
	game_scene.visible = false
	options_menu.visible = false

func game_started(): 
	game_scene.visible = true

func options_menu_opened(): 
	options_menu.show()

func _process(delta):
	if game_scene.visible:
		if Input.is_action_just_pressed("pausa"): 
			pause()

func pause(): 
	if paused: 
		pause_menu.hide()
		Engine.time_scale = 1
	else: 
		pause_menu.show()
		Engine.time_scale = 0
	paused = not paused
