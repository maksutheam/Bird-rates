extends Node


var money := 5 # players money

var danger := 0 # players notoriety
var max_danger := 1
var min_danger := 0

var day := 0

var allies := 0

var food := 3
var one_food_left = false

enum ShipName {FISHING, CRUISER, CARGO, TANKER, BATTLESHIP}

var investors_share := 0

var current_target: TargetShip = TargetShip.new()

#weird hack but whatever lmao
var target_selected := false

var crnt_target_danger = current_target.danger
var crnt_target_id = current_target.id
var crnt_target_name = current_target.name

var loot_gained := 0

var show_tutorial := true

func next_day():
	day += 1
	food -= 1 * allies
	if food == 1:
		#Älä anna pelaajan odottaa lunnaita neuvottelussa
		one_food_left = true
	elif food <= 0:
		# Häviä peli
		pass
	else:
		one_food_left = false
