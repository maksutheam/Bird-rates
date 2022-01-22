extends Node2D


onready var loot_amount = $CanvasLayer/ResultsUI/Results/Info/Gains/Loot/Amount

onready var investor_share = $CanvasLayer/ResultsUI/Results/Info/Costs/Investor/Amount
onready var investor_percent = $CanvasLayer/ResultsUI/Results/Info/Costs/Investor/Percent

onready var mercenary_share = $CanvasLayer/ResultsUI/Results/Info/Costs/Mercenary/Amount
onready var mercenary_percent = $CanvasLayer/ResultsUI/Results/Info/Costs/Mercenary/Percent

onready var player_profit = $CanvasLayer/ResultsUI/Results/Info/Profit/Players/Amount
onready var player_danger = $CanvasLayer/ResultsUI/Results/Info/Profit/PlayerDanger/Amount

var money_get = 0

export(PackedScene) var main

func _ready():
	var inv_per
	var inv_shr
	
	if not global.investors_share == 0:
		inv_per = global.investors_share
		inv_shr = (global.loot_gained / inv_per)
	else:
		inv_per = 0
		inv_shr = 0
	investor_share.text = inv_shr as String
	var rest_of_loot = (global.loot_gained - inv_shr) as String
	loot_amount.text = global.loot_gained as String
	investor_percent.text = global.investors_share as String
	mercenary_share.text = global.allies as String
	investor_share.text = (inv_shr) as String
	if global.allies == 0:
		mercenary_percent.text = "0"
		mercenary_share.text = "0"
		player_profit.text = rest_of_loot as String
		money_get = rest_of_loot
	else:
		var single_share = (rest_of_loot / (global.allies + 1))
		var plr_share = (single_share * 2)
		var merc_share = (rest_of_loot - plr_share)
		player_profit.text = plr_share as String
		money_get = plr_share
		mercenary_share.text = merc_share as String
		mercenary_percent.text = (single_share * global.allies) as String
	
	player_danger.text = global.crnt_target_danger as String
	
	global.money += money_get as int
	if global.crnt_target_danger == 0:
		global.max_danger += 1
		global.min_danger += 1
		global.danger += global.crnt_target_danger
	else:
		global.max_danger += global.crnt_target_danger
		global.min_danger += global.crnt_target_danger
		global.danger += global.crnt_target_danger


func _on_ContinueButton_pressed():
	get_tree().change_scene("res://Main.tscn")
