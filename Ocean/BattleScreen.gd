extends VBoxContainer


var player_gunmen = global.allies
var enemy_gunmen = global.current_target.danger

onready var player_field = $Fighters/Player
onready var enemy_field = $Fighters/Enemy

onready var player_fighters_label = $Buttons/Info/Player
onready var enemy_fighters_label = $Buttons/Info/Enemy

signal battle_won
signal battle_lost

func _ready():
	player_gunmen += 1
	player_fighters_label.text = player_gunmen as String
	enemy_fighters_label.text = enemy_gunmen as String

func start_fight():
	for x in 99:
		var player_shot = shoot()
		if player_shot == 0:
			#pelaaja ampui yhden vihollisen
			enemy_gunmen -= 1
			print_debug("pelaaja osui")
		else:
			print_debug("pelaaja ampui ohi")
		if player_gunmen <= 0:
			#Pelaaja hävisi ja kuoli
			print_debug("hävisit pelin")
			emit_signal("battle_lost")
			break
		elif enemy_gunmen <= 0:
			#Pelaaja voitti
			print_debug("voitit taistelun")
			emit_signal("battle_won")
			break
		var enemy_shot = shoot()
		if enemy_shot == 0:
			#Vihollinen osui pelaajaan
			player_gunmen -= 1
			print_debug("vihu osui")
		else:
			print_debug("vihu ampui ohi")

func shoot():
	randomize()
	var hit_or_miss = randi() % 2
	return hit_or_miss

func _on_FightButton_pressed():
	start_fight()
