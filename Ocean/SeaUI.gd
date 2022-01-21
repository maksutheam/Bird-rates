extends Control


onready var negotiation = $Negotiation
onready var battle = $BattleScreen
onready var battle_won = $BattleWonScreen

export(PackedScene) var results


func _ready():
	negotiation.hide()
	battle.show()
	battle_won.hide()


func _on_NegotiateButton_pressed():
	negotiation.show()
	battle.hide()
	battle_won.hide()


func _on_Negotiation_go_back():
	if negotiation.current_state == 1:
		negotiation.hide()
		battle.show()
		battle_won.hide()
	elif negotiation.current_state == 2:
		negotiation.hide()
		battle.hide()
		battle_won.show()


func _on_BattleScreen_battle_won():
	negotiation.hide()
	battle.hide()
	battle_won.show()


func _on_Loot_pressed():
	get_tree().change_scene_to(results)


func _on_Ransom_pressed():
	negotiation.current_state = 2
	negotiation.set_state(negotiation.current_state)
	negotiation.show()
	battle.hide()
	battle_won.hide()
