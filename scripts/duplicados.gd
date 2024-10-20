extends Node2D

@export var player : CharacterBody2D
@export var tauro : CharacterBody2D

@onready var players : Node2D = $Players
@onready var tauros : Node2D = $Tauros
var despl : Array = [Vector2(-368-112,400-176),Vector2(592-112,432-176),Vector2(112-112,-(-304-176)),Vector2(-368-112,-80-176),Vector2(592-112,-48-176),Vector2(112-112,-304-176)]


func _physics_process(delta):
	var players_c = players.get_children()
	var tauros_c = tauros.get_children()
	for p in range(len(players_c)):
		players_c[p].global_position = player.global_position + despl[p]
		tauros_c[p].global_position = tauro.global_position + despl[p]
		tauros_c[p].rotation = tauro.rotated_tauro.rotation
		#print(tauro.global_position + despl[p])
