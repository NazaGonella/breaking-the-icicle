extends Node2D

func deactivate():
	var children : Array = get_children()
	for h in get_children():
		h.monitoring = false
		h.monitorable = false

func _on_l_1_body_entered(body):
	if body.name == "Muros":
		return
	body.globalhistory.append(body.mano.global_position)
	body.global_position = body.global_position + Vector2(15 * 32, 8 * 32)
	print("L1")
	body.tphistory.append(body.mano.global_position)
	body.globalhistory.append(body.mano.global_position)

func _on_r_1_body_entered(body):
	if body.name == "Muros":
		return
	body.globalhistory.append(body.mano.global_position)
	body.global_position = body.global_position + Vector2(-15 * 32, -8 * 32)
	print("R1")
	body.tphistory.append(body.mano.global_position)
	body.globalhistory.append(body.mano.global_position)
	
func _on_l_2_body_entered(body):
	if body.name == "Muros":
		return
	body.globalhistory.append(body.mano.global_position)
	body.global_position = body.global_position + Vector2(15 * 32, -7 * 32)
	print("L2")
	body.tphistory.append(body.mano.global_position)
	body.globalhistory.append(body.mano.global_position)

func _on_r_2_body_entered(body):
	if body.name == "Muros":
		return
	body.globalhistory.append(body.mano.global_position)
	body.global_position = body.global_position + Vector2(-15 * 32, 7 * 32)
	print("R2")
	body.tphistory.append(body.mano.global_position)
	body.globalhistory.append(body.mano.global_position)

func _on_u_1_body_entered(body):
	if body.name == "Muros":
		return
	body.globalhistory.append(body.mano.global_position)
	body.global_position = body.global_position + Vector2(0, 15 * 32)
	print("U1")
	body.tphistory.append(body.mano.global_position)
	body.globalhistory.append(body.mano.global_position)

func _on_u_2_body_entered(body):
	if body.name == "Muros":
		return
	body.globalhistory.append(body.mano.global_position)
	body.global_position = body.global_position + Vector2(0, 15 * 32)
	print("U2")
	body.tphistory.append(body.mano.global_position)
	body.globalhistory.append(body.mano.global_position)

func _on_d_1_body_entered(body):
	if body.name == "Muros":
		return
	body.globalhistory.append(body.mano.global_position)
	body.global_position = body.global_position + Vector2(0, -15 * 32)
	print("D1")
	body.tphistory.append(body.mano.global_position)
	body.globalhistory.append(body.mano.global_position)

func _on_d_2_body_entered(body):
	if body.name == "Muros":
		return
	body.globalhistory.append(body.mano.global_position)
	body.global_position = body.global_position + Vector2(0, -15 * 32)
	print("D2")
	body.tphistory.append(body.mano.global_position)
	body.globalhistory.append(body.mano.global_position)
