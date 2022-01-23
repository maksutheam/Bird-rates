class_name Gunman
extends Sprite


onready var anim = $AnimationPlayer

var spawn_location := Vector2.ZERO

signal shoot

func _ready():
	anim.playback_speed = rand_range(-1.5, 1.5)
	anim.play("Idle")

func shoot():
	anim.play("SHoot")
	yield(anim,"animation_finished")

func die():
	anim.play("Die")
	yield(anim,"animation_finished")
	queue_free()

func spawn():
	position = spawn_location
