extends Node2D

@export var player : CharacterBody2D

@onready var players : Node2D = $Players
var despl : Array = [Vector2(-368-112,400-176),Vector2(592-112,432-176),Vector2(112-112,176-656),Vector2(-368-112,-80-176),Vector2(592-112,-48-176),Vector2(112-112,-304-176)]


func _physics_process(delta):
	var players_c = players.get_children()
	for p in range(len(players_c)):
		players_c[p].global_position = player.global_position + despl[p] 
