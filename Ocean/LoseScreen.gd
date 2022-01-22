extends Node2D

onready var reason = $CanvasLayer/Control/reason


func _ready():
	reason.text = global.lose_reason


func _on_Button_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
