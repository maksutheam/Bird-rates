extends HBoxContainer


onready var money_label = $Money/MoneyAmount
onready var danger_label = $Danger/DangerAmount
onready var day_label = $Time/DayAmount
onready var food_label = $Food/FoodAmount
onready var ally_amount = $Allies/AllyAmount


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	money_label.text = global.money as String
	day_label.text = global.day as String
	danger_label.text = global.danger as String
	food_label.text = global.food as String
	ally_amount.text = global.allies as String
