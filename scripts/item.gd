extends Area2D

@export var sprite : Sprite2D
@onready var pick_up_action_signal : TextureRect = $pick_up

var item_on_ground : String = "ESPADA"

@onready var espada_texture : Texture = preload("res://assets/espada.png")
@onready var soga_texture : Texture = preload("res://assets/ovillo.png")

func _on_body_entered(body):
	if body.name == "Player":
		body.canSwitch = true
		body.grab_item.connect(cambiar_sprite)
		pick_up_action_signal.visible = true
		

func _on_body_exited(body):
	if body.name == "Player":
		body.canSwitch = false
		pick_up_action_signal.visible = false

func cambiar_sprite():
	if item_on_ground == "ESPADA":
		sprite.texture = soga_texture
		item_on_ground = "SOGA"
	elif item_on_ground == "SOGA":
		sprite.texture = espada_texture
		item_on_ground = "ESPADA"
