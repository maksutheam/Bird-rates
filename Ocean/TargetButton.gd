extends Button


onready var target_info_container = $HBoxContainer
onready var target_name_label = $HBoxContainer/TargetName
onready var target_danger_bar = $HBoxContainer/VBoxContainer/DangerBar
onready var select_ship = $SelectShip
onready var target = $TargetShip

export var show_current_target := false

func _ready():
	if show_current_target:
		if global.current_target == null:
			target_info_container.hide()
			select_ship.show()
	else:
		target.make_new_target()
		target_name_label.text = target.ship_type
		target_danger_bar.value = target.danger

func _process(delta):
	# Updates when player selects target
	if not global.current_target == null and show_current_target:
		select_ship.hide()
		target_info_container.show()
		target_name_label.text = global.current_target.ship_type
		target_danger_bar.value = global.current_target.danger

func _on_TargetButton_pressed():
	global.current_target = target
	print_debug(global.current_target)

