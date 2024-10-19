extends Node2D

var WAITING : bool = false

@export var group_name : String
@export var tauro : CharacterBody2D
@export var rotated_tauro : Node2D
@export var timer : Timer
#@export var tauro_collision : CollisionShape2D

var positions : Array 
var temp_positions : Array
var current_position : Marker2D
 
var direction : Vector2 = Vector2.ZERO
var lookout_directions : Array[String] = []

var last_marker : Marker2D = null

func _ready():
	positions = get_tree().get_nodes_in_group(group_name)
	_get_positions()
	_get_next_position()
 
func _physics_process(_delta):
	#print("tauro.CHASING: ", tauro.CHASING)
	#print(current_position.global_position)
	#print("cur: ", current_position.global_position)
	#print("pos: ", global_position)
	if global_position.distance_to(current_position.position) < 2 and not tauro.CHASING:
		lookout_directions = current_position.directions
		tauro.global_position = current_position.global_position
		last_marker = current_position
		_get_next_position()
		var rot = atan2(direction.y, direction.x) - PI/2
		timer.wait_time = 0.25
		WAITING = true
		timer.start()
		await timer.timeout
		for d in lookout_directions:
			if tauro.CHASING:
				#print("pushed: ", current_position.global_position)
				#print("pushed: ", last_marker.global_position)
				#temp_positions.push_front(current_position)
				#temp_positions.push_front(last_marker)
				break
			rotated_tauro.rotation = _get_lookout_direction(d)
			timer.wait_time = current_position.wait_seconds
			timer.start()
			await timer.timeout
		WAITING = false
		if not tauro.CHASING:
			rotated_tauro.rotation = rot
 
func _get_positions():
	temp_positions = positions.duplicate()
	#temp_positions.shuffle()
 
func _get_next_position():
	#print("hola")
	if temp_positions.is_empty():
		_get_positions()
	current_position = temp_positions.pop_front()
	#current_position = temp_positions[0]
	direction = to_local(current_position.position).normalized()

func _get_lookout_direction(dir : String) -> float:
	if dir == "UP":
		return -PI
	if dir == "DOWN":
		return 0
	if dir == "LEFT":
		return PI/2
	if dir == "RIGHT":
		return -PI/2
	return 0

func _tauro_crash():
	temp_positions.push_front(current_position)
	temp_positions.push_front(last_marker)
	_get_next_position()
	timer.wait_time = 1.5
	WAITING = true
	timer.start()
	await timer.timeout
	WAITING = false
	var rot = atan2(direction.y, direction.x) - PI/2
	rotated_tauro.rotation = rot
	
