extends CharacterBody2D

var CHASING : bool = false
var griddedpos: Vector2i = Vector2i(0,0)

@export var patrulla_component : Node2D
@export var raycasts : Node2D

var temp_vel = Vector2.ZERO

const SPEED = 50.0

func _physics_process(delta):
	griddedpos= Vector2i(global_position.x/32,global_position.y/32)
	#velocity.y = delta * SPEED
	#if CHASING:
		#print("chasing")
	var temp = false
	for r in raycasts.get_children():
		if r.is_colliding():
			if r.get_collider().name == "Player":
				if not CHASING:
					temp_vel = (r.get_collider().global_position - global_position).normalized() * SPEED
				if abs(temp_vel.x) > abs(temp_vel.y):
					temp_vel.y = 0
				else:
					temp_vel.x = 0
				#print("temp_vel after: ", temp_vel)
				velocity = temp_vel
				move_and_slide()
				CHASING = true
				temp = true
	if not temp:
		CHASING = false
	if not patrulla_component.WAITING and not CHASING:
		#print("patrolling")
		velocity = patrulla_component.direction * SPEED
		move_and_slide()
	#print(raycast.is_colliding())
	#print(raycast.get_collider())
