extends RigidBody2D

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		linear_velocity.x += 2
