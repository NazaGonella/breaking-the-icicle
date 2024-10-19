extends Node2D
@export var player:CharacterBody2D
@export var tauro:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	for i in range(len(player.griddedhistory)):
		if tauro.griddedpos==player.griddedhistory[i]:
			#print("el tauro se cruza con el hilo en",tauro.griddedpos, "globalhistory:",player.globalhistory)
			for j in range(len(player.globalhistory)-1,0,-1):
				#print(len(player.globalhistory))
				#print(j)
				#print(dist)
				#print(Vector2(player.globalhistory[j]))
				#print(dist==player.globalhistory[j])
				if share_tile(tauro.griddedpos,player.globalhistory[j]/64):
					print("tauro:",tauro.griddedpos,"player:",player.globalhistory[j]/64)
					player.globalhistory=player.globalhistory.slice(j+1,len(player.globalhistory)-1)
					player.griddedhistory=player.griddedhistory.slice(i+1,len(player.griddedhistory)-1)
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
	
func share_tile(vector1 : Vector2, vector2 : Vector2):
	var dist : Vector2 = (vector2)-(vector1)
	if dist.x<1 and dist.x>=0 and dist.y<1 and dist.y>=0:
		return true
