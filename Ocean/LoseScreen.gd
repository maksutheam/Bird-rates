extends Node2D

onready var reason = $CanvasLayer/Control/reason


func _ready():
	reason.text = global.lose_reason
	global.money = 5 # players money
	global.danger = 0 # players notoriety
	global.max_danger = 1
	global.min_danger = 0
	global.day = 0
	global.allies = 0
	global.food = 3
	global.one_food_left = false
	global.investors_share = 0
	global.current_target = TargetShip.new()
	#weird hack but whatever lmao
	global.target_selected = false
	global.loot_gained = 0
	global.show_tutorial = true



func _on_Button_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
