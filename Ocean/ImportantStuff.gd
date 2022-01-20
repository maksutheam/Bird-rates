extends HBoxContainer


onready var money_label = $Money/MoneyAmount
onready var danger_label = $Danger/DangerAmount
onready var day_label = $Time/DayAmount


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	money_label.text = global.money as String
	day_label.text = global.day as String
	danger_label.text = global.danger as String
