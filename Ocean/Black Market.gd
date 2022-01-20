extends HBoxContainer



func _on_Gunman_item_bought():
	global.allies += 1


func _on_Food_item_bought():
	global.food += 1
