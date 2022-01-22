class_name Gunman
extends Sprite


onready var anim = $AnimationPlayer

var spawn_location := Vector2.ZERO

func _ready():
	anim.playback_speed = rand_range(-1.5, 1.5)

func shoot():
	anim.play("SHoot")

func die():
	anim.play("Die")

func spawn():
	position = spawn_location
