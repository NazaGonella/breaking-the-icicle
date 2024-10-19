extends Node2D
@export var player:CharacterBody2D
@export var tauro:CharacterBody2D

var restos: Array = []
var espejos: Array = [Vector2(0,0),Vector2(-480,224),Vector2(0,480),Vector2(480,256),Vector2(480,-224),Vector2(-480,-256),Vector2(0,-480)]

var ANCHO_SOGA : float = 1

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
				if share_tile(tauro.griddedpos,player.globalhistory[j]/32):
					#print("tauro:",tauro.griddedpos,"player:",player.globalhistory[j]/32)
					restos.append(player.globalhistory[j])
					player.globalhistory=player.globalhistory.slice(j+1,len(player.globalhistory)-1)
					player.griddedhistory=player.griddedhistory.slice(i+1,len(player.griddedhistory)-1)

					#print(player.globalhistory)
					break
			break
	if player.drawNow:
		queue_redraw()


func _draw():
	var string : PackedVector2Array = []
	#for point in player.globalhistory:
		#draw_circle(point, 3,Color.DARK_RED)4
	for despl in espejos:
		string=[]
		var strings : Array = []
		for coord in player.globalhistory:
			if player.tphistory.has(coord):
				strings.append(string)
				string=[]
			string.append(Vector2(coord[0]+despl.x, coord[1]+despl.y))
		strings.append(string)
		for s in strings:
			draw_polyline(s, Color.DARK_RED, ANCHO_SOGA)
		for casilla in restos:
			draw_rect(Rect2(casilla.x+despl.x,casilla.y+despl.y,3,3),Color.DARK_RED)
			draw_rect(Rect2(casilla.x+despl.x+10,casilla.y+despl.y+10,3,6),Color.DARK_RED)
	
func share_tile(vector1 : Vector2, vector2 : Vector2):
	var dist : Vector2 = (vector2)-(vector1)
	if dist.x<1 and dist.x>=0 and dist.y<1 and dist.y>=0:
		return true
