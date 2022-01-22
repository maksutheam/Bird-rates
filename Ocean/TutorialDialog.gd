extends AcceptDialog

onready var check = $CheckBox


func _ready():
	if global.show_tutorial:
		popup()


func _on_CheckBox_toggled(button_pressed):
	if button_pressed:
		global.show_tutorial = false
	else:
		global.show_tutorial = true
