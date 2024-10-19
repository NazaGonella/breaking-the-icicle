extends Control

@onready var video_stream_player = $VideoStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	video_stream_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
