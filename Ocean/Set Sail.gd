extends VBoxContainer


export(PackedScene) var sea

func _on_Go_pressed():
	get_tree().change_scene_to(sea)
