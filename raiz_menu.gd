extends Node2D

@onready var main_menu: Control = $CanvasLayer/Menus/MainMenu
#@onready var game_scene : Node2D = $game
#@onready var camera : Camera2D = $Camera2D
@onready var options_menu : Control = $CanvasLayer/Menus/OptionsMenu
@onready var pause_menu : Control = $CanvasLayer/Menus/PauseMenu
@onready var button_switching = $button_switching
@onready var menus = $CanvasLayer/Menus

var game_scene : Node2D = null

var preloaded_game_scene = preload("res://scenes/game.tscn")
var preloaded_pause_scene = preload("res://scenes/menus/pause_menu.tscn")
var preloaded_main_menu = preload("res://scenes/menus/main_menu.tscn")
var preloaded_options_menu = preload("res://scenes/menus/options_menu.tscn")

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
	#camera.visible = false
	#game_scene.visible = false

func game_started(): 
	#game_scene.visible = true
	#camera.visible = true
	main_menu.hide()
	game_scene = preloaded_game_scene.instantiate()
	game_scene.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(game_scene)
	
func reload_pause_menu(): 
	pause_menu.queue_free()
	pause_menu = preloaded_pause_scene.instantiate()
	menus.add_child(pause_menu)
	pause_menu.options_menu.connect(options_menu_opened_from_pause)
	pause_menu.main_menu.connect(reopen_main_menu)

func reload_options_menu(): 
	options_menu.queue_free()
	options_menu = preloaded_options_menu.instantiate()
	menus.add_child(options_menu)

func options_menu_opened_from_menu(): 
	options_menu.open_from(main_menu)
	options_menu.refocus()

func options_menu_opened_from_pause(): 
	options_menu.open_from(pause_menu)
	options_menu.refocus()

func reopen_main_menu():
	if not get_tree().paused: 
		get_tree().paused = true
	else: 
		get_tree().paused = false
	get_tree().reload_current_scene()


func _process(_delta):
	if game_scene:
		if Input.is_action_just_pressed("Pausa"):
			#print("hola")
			button_switching.play()
			pause()

func pause(): 
	if not get_tree().paused: 
		get_tree().paused = true
		pause_menu.show()
		pause_menu.refocus()
	else: 
		get_tree().paused = false
		pause_menu.hide()
	#print(get_tree().paused)
		
