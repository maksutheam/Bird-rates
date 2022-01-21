extends Node


var money := 0

var danger := 0
var max_danger := 3
var min_danger := 0

var day := 0

var allies := 1

var food := 5

enum ShipName {FISHING, CRUISER, CARGO, TANKER, BATTLESHIP}
enum ShipLoot {NONE, OIL, FISH}

var current_target: TargetShip = TargetShip.new()

#weird hack but whatever lmao
var crnt_target_danger = current_target.danger
var crnt_target_id = current_target.id
var crnt_target_name = current_target.name

