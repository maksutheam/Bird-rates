class_name TutorialDialog
extends AcceptDialog

onready var check = $CheckBox
var tutorial_toggle := false

func _ready():
	if global.show_tutorial:
		popup()


func _on_CheckBox_toggled(button_pressed):
	if button_pressed:
		tutorial_toggle = true
	else:
		tutorial_toggle = false


func _on_TutorialDialog_confirmed():
	if tutorial_toggle:
		global.show_tutorial = false
	else:
		global.show_tutorial = true
