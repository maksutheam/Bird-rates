extends Node


var money := 0 # players money

var danger := 0 # players danger-level
var max_danger := 3
var min_danger := 0

var day := 0

var allies := 1

var food := 5

enum ShipName {FISHING, CRUISER, CARGO, TANKER, BATTLESHIP}
enum ShipLoot {NONE, OIL, FISH}

var current_target: TargetShip = TargetShip.new()

#weird hack but whatever lmao
var target_selected := false

var crnt_target_danger = current_target.danger
var crnt_target_id = current_target.id
var crnt_target_name = current_target.name

func next_day():
	day += 1
	food -= 1
	if food == 1:
		#Älä anna pelaajan odottaa lunnaita neuvottelussa
		pass
	if food <= 0:
		# Häviä peli
		pass
