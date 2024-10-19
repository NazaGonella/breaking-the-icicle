extends Node2D

@onready var main_menu: Control = $Menus/MainMenu
@onready var game_scene : Node2D = $GameScene
@onready var camera : Camera2D = $Camera2D
@onready var options_menu : Control = $Menus/OptionsMenu
@onready var pause_menu : Control = $Menus/PauseMenu
@onready var button_switching = $button_switching
@onready var menus = $Menus

var preloaded_game_scene = preload("res://scenes/game_scene.tscn")
var preloaded_pause_scene = preload("res://scenes/menus/pause_menu.tscn")
var paused : bool = false

func _ready():
	main_menu.start_game.connect(game_started)
	main_menu.options_menu.connect(options_menu_opened_from_menu)
	pause_menu.options_menu.connect(options_menu_opened_from_pause)
	pause_menu.main_menu.connect(reopen_main_menu)
	for menu in menus.get_children(): 
		if menu == main_menu: 
			menu.visible = true
		else: 
			menu.visible = false
	camera.visible = false
	game_scene.visible = false

func game_started(): 
	game_scene.visible = true
	main_menu.hide()
	
func options_menu_opened_from_menu(): 
	options_menu.open_from(main_menu)

func options_menu_opened_from_pause(): 
	options_menu.open_from(pause_menu)

func reopen_main_menu():
	pause()
	game_scene.queue_free()
	game_scene = preloaded_game_scene.instantiate()
	add_child(game_scene)
	game_scene.visible = false
	main_menu.show()
	pause_menu.queue_free()
	pause_menu = preloaded_pause_scene.instantiate()
	add_child(pause_menu)
	pause_menu.hide()

func _process(delta):
	main_menu.start_game.connect(game_started)
	main_menu.options_menu.connect(options_menu_opened_from_menu)
	pause_menu.options_menu.connect(options_menu_opened_from_pause)
	pause_menu.main_menu.connect(reopen_main_menu)
	if game_scene.visible:
		if Input.is_action_just_pressed("pausa"): 
			button_switching.play()
			pause()

func pause(): 
	if not get_tree().paused: 
		get_tree().paused = true
		pause_menu.queue_free()
		pause_menu = preloaded_pause_scene.instantiate()
		add_child(pause_menu)
		pause_menu.show()
	else: 
		get_tree().paused = false
		pause_menu.queue_free()
		pause_menu = preloaded_pause_scene.instantiate()
		add_child(pause_menu)
		pause_menu.hide()
		
		
