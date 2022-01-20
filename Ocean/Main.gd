extends Node2D


onready var heist_button = $UI/PortHUD/Buttons/HeistButton
onready var fishing_button = $UI/PortHUD/Buttons/FishButton

export(PackedScene) var plan_heist

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_FishButton_pressed():
	pass

func _on_HeistButton_pressed():
	get_tree().change_scene_to(plan_heist)
