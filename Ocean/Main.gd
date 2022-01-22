extends Node2D


onready var heist_button = $UI/PortHUD/Buttons/HeistButton
onready var fishing_button = $UI/PortHUD/Buttons/FishButton

export(PackedScene) var plan_heist
export(PackedScene) var fishing

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug(global.danger)
	print_debug(global.food)

func _on_FishButton_pressed():
	get_tree().change_scene_to(fishing)

func _on_HeistButton_pressed():
	get_tree().change_scene_to(plan_heist)
