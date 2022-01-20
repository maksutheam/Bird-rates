extends ColorRect


var gunman = preload("res://Gunman.tscn")
onready var label = $Label
onready var player = $Player

export var is_player := true
var total_fighters: int

func _ready():
	if is_player:
		player.show()
		set_fighters(global.allies)
	else:
		player.hide()
		set_fighters(global.current_target.danger)

func set_fighters(new_fighters):
	for i in new_fighters:
		var new_gunman = gunman.instance()
		if not is_player:
			new_gunman.flip_h = true
		else:
			new_gunman.modulate = Color.yellow
		add_child(new_gunman)
		randomize()
		new_gunman.position = Vector2(rand_range(0, rect_size.x), rand_range(0, rect_size.y))
	
	label.text = new_fighters as String
