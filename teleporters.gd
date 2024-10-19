extends Node2D

func _on_l_1_body_entered(body):
	if body.name == "Muros":
		return
	body.global_position = body.global_position + Vector2(15 * 32, 8 * 32)
	print("L1")

func _on_r_1_body_entered(body):
	if body.name == "Muros":
		return
	body.global_position = body.global_position + Vector2(-15 * 32, -8 * 32)
	print("R1")
	
func _on_l_2_body_entered(body):
	if body.name == "Muros":
		return
	body.global_position = body.global_position + Vector2(15 * 32, -7 * 32)
	print("L2")

func _on_r_2_body_entered(body):
	if body.name == "Muros":
		return
	body.global_position = body.global_position + Vector2(-15 * 32, 7 * 32)
	print("R2")
