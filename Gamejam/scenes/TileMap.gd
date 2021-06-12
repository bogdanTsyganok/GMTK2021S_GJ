extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func sendCords(cords):
	var pos = world_to_map(cords)
	var rtn = get_cell(pos.x, pos.y)
	get_tree().call_group("player","receiveCords", rtn)
	get_tree().call_group("ghost","receiveCords", rtn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
