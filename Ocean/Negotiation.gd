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

onready var dialog = $Offeree/HBoxContainer/Dialogue
onready var accept_button = $Offeree/HBoxContainer/Buttons/Accept
onready var back_button = $Offeree/HBoxContainer/Buttons/Leave
onready var patience = $Offeree/HBoxContainer/Portrait/Patience/PatienceBar

onready var portrait = $Offeree/HBoxContainer/Portrait/InvestorPortrait
export(Texture) var porvari
export(Texture) var palkkasoturi
export(Texture) var kapteeni

var player_offer_percent := 0
var player_investment: int = 0

var min_share := 0 #min % the investor is fine with getting
var max_investment := 0 # max € the investor can give to the player

var max_robbery := 0 #max % of loot the enemy will give up on

var max_ransom := 0 #max € the ship owner can give to the player when holding for ransom

var max_patience := 4 #how much the player can ask before they give up


enum States {INVEST, NEGOTITATE, HOSTAGE}
export var current_state: int

signal go_back
signal go_to_results

func _ready():
	patience.max_value = max_patience
	calculate_offers()
	set_state(current_state)

func check_offer():
	if current_state == States.INVEST: #Investointi
		if patience.value >= max_patience:
			dialog.text = "I tire of this, come back when you take this seriously"
			offer_button.disabled = true
		elif min_share <= player_offer_percent and player_investment <= max_investment:
			#Good deal
			dialog.text = "A good deal, I'd wager."
			print_debug("jee")
			accept_button.disabled = false
		elif player_investment > max_investment:
			#Player wants too much money
			dialog.text = "Do I look like a bank to you? Maybe for less money."
			print_debug("ei noi paljo")
			accept_button.disabled = true
		elif player_offer_percent < min_share:
			#Too little %
			dialog.text = "A pitiful share. I want a larger %."
			print_debug("lissää")
			accept_button.disabled = true
		
		patience.value += 1
	elif current_state == States.NEGOTITATE: #Neuvottelu
		if patience.value >= max_patience:
			dialog.text = "Enough, eat lead!"
			offer_button.disabled = true
		if player_offer_percent < max_robbery:
			#Good deal
			dialog.text = "Fine, you can have that if you leave us alone."
		elif player_offer_percent > max_robbery:
			dialog.text = "Not giving up on that much loot!"
		
		patience.value += 1
	elif current_state == States.HOSTAGE:
		if player_investment > max_ransom:
			dialog.text = "I am sorry, I do not have that much money."
		elif player_investment <= max_ransom:
			dialog.text = "So be it then."


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
			dialog.text = "So, which ship are you boarding exactly?"
			portrait.texture = porvari
		1:#Negotiate
			budget.visible = false
			share.visible = true
			back_button.visible = true
			patience.visible = true
			share_comment.text = "Hand over this % of the loot, and nobody gets hurt:"
			dialog.text = "How much to leave us alone?"
			portrait.texture = palkkasoturi
		2:#Hostage
			if global.one_food_left:
				offer_button.disabled = true
				accept_button.disabled = true
			else:
				offer_button.disabled = false
				accept_button.disabled = true
			budget.visible = true
			share.visible = false
			back_button.visible = true
			patience.visible = false
			budget_label.text = "Give me this much € and you get your boat and crew back:"
			dialog.text = "How much for you to give my crew back?"
			portrait.texture = kapteeni
			offer_button.text = "Make offer (+1 day)"


func calculate_offers():
	randomize()
	min_share = (randi() % 50 + 5) - (global.crnt_target_danger * 2) #int from 1 to 50 minus danger
	max_investment = (global.crnt_target_danger + 9)
	max_robbery = (randi() % 100)
	max_ransom = (global.crnt_target_danger * 2) + (floor(rand_range(-3, 3)))
	print_debug(min_share, "% ", max_investment, "€ ", max_robbery,"% ", max_ransom, "€")


func _on_OfferButton_pressed():
	player_offer_percent = share_bar.value
	player_investment = budget_amount.value
	if current_state == 3:
		global.next_day()
	check_offer()


func _on_Accept_pressed():
	#If investment: add investment to players' money and disable the dialog
	#If Negotiating: go to the results screen
	#If Hostage: if player has enough food, wait those days and go to results
	if current_state == 0:
		global.money += player_investment
		global.investors_share = player_offer_percent
		offer_button.disabled = true
		accept_button.disabled = true
	elif current_state == 1:
		global.loot_gained = (global.crnt_target_danger / player_offer_percent)
		print_debug(global.loot_gained)
		emit_signal("go_to_results")
	elif current_state == 2:
		global.loot_gained = player_investment
		emit_signal("go_to_results")


func _on_BudgetAmount_value_changed(value):
	player_investment = value


func _on_Leave_pressed():
	emit_signal("go_back")
