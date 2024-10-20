extends Marker2D

@export_flags("UP", "DOWN", "RIGHT", "LEFT") var lookout_directions = 0
var wait_seconds : float = 1.25

var directions : Array[String] = []

func _ready():
	wait_seconds
	if lookout_directions & 1:
		#print("UP is selected")
		directions.append("UP")

	if lookout_directions & 2:
		#print("DOWN is selected")
		directions.append("DOWN")

	if lookout_directions & 4:
		#print("RIGHT is selected")
		directions.append("RIGHT")

	if lookout_directions & 8:
		#print("LEFT is selected")
		directions.append("LEFT")

