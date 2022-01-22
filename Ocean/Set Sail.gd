extends VBoxContainer


export(PackedScene) var sea

func _on_Go_pressed():
	global.money -= 1
	global.next_day()
	get_tree().change_scene_to(sea)
