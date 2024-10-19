extends Node2D

@onready var main_menu: Control = $Menus/MainMenu
@onready var game_scene : Node2D = $GameScene
@onready var camera : Camera2D = $Camera2D
@onready var options_menu : Control = $Menus/OptionsMenu
@onready var pause_menu : Control = $PauseMenu
@onready var button_switching = $button_switching
@onready var menus = $Menus



var paused : bool = false

func _ready():
	main_menu.start_game.connect(game_started)
	main_menu.options_menu.connect(options_menu_opened)
	pause_menu.options_menu.connect(options_menu_opened)
	for menu in menus.get_children(): 
		if menu == main_menu: 
			menu.visible = true
		else: 
			menu.visible = false
	camera.visible = false
	game_scene.visible = false

func game_started(): 
	game_scene.visible = true

func options_menu_opened(): 
	options_menu.show()

func _process(delta):
	if game_scene.visible:
		if Input.is_action_just_pressed("pausa"): 
			button_switching.play()
			pause()

func pause(): 
	if not get_tree().paused: 
		get_tree().paused = true
		pause_menu.show()
	else: 
		get_tree().paused = false
		pause_menu.hide()
