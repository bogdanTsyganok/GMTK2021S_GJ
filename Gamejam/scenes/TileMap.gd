extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var placedMirrors = 2



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func sendCords(cords):
	var pos = world_to_map(cords)
	var rtn = get_cell(pos.x, pos.y)
	print(pos)
	get_tree().call_group("player","receiveCords", rtn)
	get_tree().call_group("ghost","receiveCords", rtn)
	
func sendCordsNoNotify(cords):
	var pos = world_to_map(cords)
	var rtn = get_cell(pos.x, pos.y)
	print(pos)

func spawnObject(cords):
	var pos = world_to_map(cords)
	var scene = load("res://scenes/Mirror.tscn")
	var secondMirror = load("res://scenes/GhostPortal.tscn")
	var portalObj = secondMirror.instance()
	var mirObject = scene.instance()
	portalObj.place(cords)
	mirObject.place(cords)
	add_child(mirObject)
	mirObject.add_child(portalObj)
	
	placedMirrors = placedMirrors + 1
	
func takeMirror():
	placedMirrors = placedMirrors - 1
	
func teleport(startPos):
	var children = get_children()
	if children.size() == 2:
		#print("teleport noises")
		var pos = Vector2.ZERO
		if children[0].position == (startPos - Vector2(208, 0)):
			pos = children[1].position + Vector2(208,0)
		else:
			pos = children[0].position + Vector2(208,0)
		
		get_tree().call_group("ghost", "teleport", pos)
