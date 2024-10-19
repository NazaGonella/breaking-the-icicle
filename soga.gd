extends Node2D

@export var player:CharacterBody2D
@export var tauro:CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(tauro.griddedpos)
	for i in range(len(player.griddedhistory)):
		if tauro.griddedpos==player.griddedhistory[i]:
			#print("el tauro se cruza con el hilo en",tauro.griddedpos, "globalhistory:",player.globalhistory)
			for j in range(len(player.globalhistory)-1,0,-1):
				#print(j)
				var dist : Vector2 = Vector2(player.globalhistory[j]/32)-Vector2(tauro.griddedpos)
				print(dist)
				#print(Vector2(player.globalhistory[j]))
				#print(dist==player.globalhistory[j])
				if dist.x<32 and dist.x>=0 and dist.y<32 and dist.y>=0:
					player.globalhistory=player.globalhistory.slice(j,len(player.globalhistory)-1)
					#print(player.globalhistory)
					break
			break
	if player.drawNow:
		queue_redraw()


func _draw():
	#for point in player.globalhistory:
		#draw_circle(point, 3,Color.DARK_RED)
	var string : PackedVector2Array = []
	for coord in player.globalhistory:
		string.append(Vector2(coord[0], coord[1]))
	draw_polyline(string, Color.DARK_RED, 3)
