tool
extends VBoxContainer


onready var share = $PlayerOffer/HBoxContainer/Share
onready var share_bar = $PlayerOffer/HBoxContainer/Share/HBoxContainer/SpinBox
onready var share_label = $PlayerOffer/HBoxContainer/Share/HBoxContainer/Percent
onready var share_comment = $PlayerOffer/HBoxContainer/Share/Comment
onready var offer_button = $PlayerOffer/HBoxContainer/OfferButton

onready var budget = $PlayerOffer/HBoxContainer/Budget
onready var budget_amount = $PlayerOffer/HBoxContainer/Budget/HBoxContainer/BudgetAmount
onready var budget_label = $PlayerOffer/HBoxContainer/Budget/Label

onready var dialog = $Offeree/HBoxContainer/Dialogue.text
onready var accept_button = $Offeree/HBoxContainer/Buttons/Accept
onready var back_button = $Offeree/HBoxContainer/Buttons/Leave
onready var patience = $Offeree/HBoxContainer/Portrait/Patience/PatienceBar

var player_offer_percent := 0
var player_investment := 0

var min_share := 0 #min % the investor is fine with getting
var max_investment := 0 # max € the investor can give to the player

var max_robbery := 0 #max % of loot the enemy will give up on

var max_ransom := 0 #max € the ship owner can give to the player when holding for ransom

var max_patience := 3 #how much the player can ask before they give up

enum States {INVEST, NEGOTITATE, HOSTAGE}
export var current_state: int

signal go_back

func _ready():
	set_state(current_state)

func check_offer():
	if current_state == States.INVEST: #Investointi
		if patience.value >= max_patience:
			dialog = "I tire of this, come back when you take this seriously"
			offer_button.disabled = true
		elif min_share < player_offer_percent and player_investment < max_investment:
			#Good deal
			dialog = "A good deal, I'd wager."
			accept_button.disabled = false
		elif player_investment > max_investment:
			#Player wants too much money
			dialog = "Do I look like a bank to you? Maybe for less money."
			accept_button.disabled = true
		elif player_offer_percent < min_share:
			#Too little %
			dialog = "A pitiful share. I want a larger %"
			accept_button.disabled = true
		
		patience.value += 1
	elif current_state == States.NEGOTITATE: #Neuvottelu
		if patience >= max_patience:
			dialog = "Enough, eat lead!"
			offer_button.disabled = true
		if player_offer_percent < max_robbery:
			#Good deal
			dialog = "Fine, you can have that if you leave us alone"
		elif player_offer_percent > max_robbery:
			dialog = "Not giving up on that much loot"
		
		patience.value += 1
	elif current_state == States.HOSTAGE:
		pass


func _on_SpinBox_value_changed(value):
	share_label.text = value as String
	player_offer_percent = value


func set_state(new_state):
	match new_state:
		0:#Invest
			budget.visible = true
			share.visible = true
			back_button.visible = false
			patience.visible = true
			budget_label.text = "I need this much:"
			share_comment.text = "I'll give you this % of the loot:"
		1:#Negotiate
			budget.visible = false
			share.visible = true
			back_button.visible = true
			patience.visible = true
			share_comment.text = "Hand over this % of the loot, and nobody gets hurt:"
		2:#Hostage
			budget.visible = true
			share.visible = false
			back_button.visible = true
			patience.visible = false
			budget_label.text = "Give me this much € and you get your boat and crew back:"


func calculate_offers():
	pass


func _on_OfferButton_pressed():
	player_offer_percent = share_bar.value
	player_investment = budget_amount
	if current_state == 3:
		global.food -= global.allies
	check_offer()


func _on_Accept_pressed():
	#If investment: add investment to players' money and disable the dialog
	#If Negotiating: go to the results screen
	#If Hostage: if player has enough food, wait those days and go to results
	pass


func _on_BudgetAmount_value_changed(value):
	player_investment = value


func _on_Leave_pressed():
	emit_signal("go_back")
