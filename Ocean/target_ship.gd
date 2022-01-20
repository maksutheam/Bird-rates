class_name TargetShip
extends Node

#Class that makes the ships the player engages with

#var target = {
#	"id": 0,
#	"name": "Fishing Boat",
#	"danger": 0,
#	"loot": 0}
var id = 0
var ship_type = 0
var danger = 1
var loot = 1

func make_new_target():
	randomize()
	var rand_id = randi() % 5
	var rand_danger = randi() % global.max_danger
	
	ship_type = rand_id
	
	match rand_id: #Choose name and loot
		0:
			ship_type = "Fishing Boat"
		1:
			ship_type = "Cruiser"
		2:
			ship_type = "Cargo"
		3:
			ship_type = "Oil Tanker"
		4:
			ship_type = "Battleship"
	
	danger = rand_danger
