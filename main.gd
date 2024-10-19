extends Node2D

@onready var main_menu = $MainMenu
@onready var game_scene = $GameScene
@onready var camera = $Camera2D
@onready var options_menu = $OptionsMenu

func _ready():
	main_menu.start_game.connect(game_started)
	main_menu.options_menu.connect(options_menu_opened)
	main_menu.visible = true
	camera.visible = false
	game_scene.visible = false
	options_menu.visible = false

func game_started(): 
	game_scene.visible = true

func options_menu_opened(): 
	options_menu.show()
	
	
