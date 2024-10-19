extends Node2D

func _on_l_1_body_entered(body):
	if body.name == "Muros":
		return
	body.globalhistory.append(body.mano.global_position)
	body.global_position = body.global_position + Vector2(15 * 32, 8 * 32)
	body.tphistory.append(body.mano.global_position)
	body.globalhistory.append(body.mano.global_position)
	print("L1")

func _on_r_1_body_entered(body):
	if body.name == "Muros":
		return
	body.globalhistory.append(body.mano.global_position)
	body.global_position = body.global_position + Vector2(-15 * 32, -8 * 32)
	body.tphistory.append(body.mano.global_position)
	body.globalhistory.append(body.mano.global_position)
	print("R1")
	
func _on_l_2_body_entered(body):
	if body.name == "Muros":
		return
	body.globalhistory.append(body.mano.global_position)
	body.global_position = body.global_position + Vector2(15 * 32, -7 * 32)
	body.tphistory.append(body.mano.global_position)
	body.globalhistory.append(body.mano.global_position)
	print("L2")

func _on_r_2_body_entered(body):
	if body.name == "Muros":
		return
	body.globalhistory.append(body.mano.global_position)
	body.global_position = body.global_position + Vector2(-15 * 32, 7 * 32)
	body.tphistory.append(body.mano.global_position)
	body.globalhistory.append(body.mano.global_position)
	print("R2")
	
func updateglobalhistory(body,vector):
	body.globalhistory.append(vector)
