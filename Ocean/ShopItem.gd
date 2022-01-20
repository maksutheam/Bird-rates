tool
extends Panel

export var item := ""
export var description := ""
export var price := 0
export(Texture) var icon

onready var item_label = $VBoxContainer/Title
onready var desc_label = $VBoxContainer/Description
onready var price_label = $VBoxContainer/HBoxContainer/Price
onready var icon_texture = $VBoxContainer/Icon

signal item_bought()

func _ready():
	update_prices()

func update_prices():
	item_label.text = item
	desc_label.text = description
	price_label.text = price as String
	icon_texture.texture = icon

func _process(delta):
	if Engine.editor_hint:
		update_prices()


func _on_BuyButton_pressed():
	if global.money >= price:
		global.money -= price
		emit_signal("item_bought")
	#
