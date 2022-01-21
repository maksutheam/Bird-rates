extends Button


onready var target_info_container = $HBoxContainer
onready var target_name_label = $HBoxContainer/TargetName
onready var target_danger_bar = $HBoxContainer/VBoxContainer/DangerBar
onready var select_ship = $SelectShip
onready var target = $TargetShip

export var show_current_target := false

func _ready():
	if show_current_target:
		target_info_container.hide()
		select_ship.show()
	else:
		target.make_new_target()
		target_name_label.text = target.ship_type
		target_danger_bar.value = target.danger

func _process(delta):
	# Updates when player selects target
	if show_current_target and global.target_selected:
		select_ship.hide()
		target_info_container.show()
		target_name_label.text = global.crnt_target_name
		target_danger_bar.value = global.crnt_target_danger

func _on_TargetButton_pressed():
	global.target_selected = true
	global.crnt_target_danger = target.danger
	global.crnt_target_name = target.ship_type
	print_debug(global.crnt_target_name)
	print_debug(global.crnt_target_danger)
