extends Camera2D

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		position.x += 2
	if Input.is_action_pressed("ui_left"):
		position.x -= 2
