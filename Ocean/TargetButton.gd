extends Button


onready var target_info_container = $HBoxContainer
onready var target_name_label = $HBoxContainer/TargetName
onready var target_danger_bar = $HBoxContainer/VBoxContainer/DangerBar
onready var select_ship = $SelectShip
onready var target = $TargetShip
onready var selected_target = $SelectedTarget

export var show_current_target := false

func _ready():
	if show_current_target:
		if selected_target.target == null:
			target_info_container.hide()
			select_ship.show()
	else:
		target.make_new_target()
		target_name_label.text = target.ship_type
		target_danger_bar.value = target.danger

func _process(delta):
	# Updates when player selects target
	if not selected_target.target == null and show_current_target:
		select_ship.hide()
		target_info_container.show()
		target_name_label.text = selected_target.target.ship_type
		target_danger_bar.value = selected_target.target.danger

func _on_TargetButton_pressed():
	selected_target.set_target(target)
	print_debug(selected_target.target)
	print_debug(selected_target.target.danger)
