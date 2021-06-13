extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var placedMirrors = 2

var endCheck = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func addToEnd():
	endCheck = endCheck + 1
	
func subFromEnd():
	endCheck = endCheck - 1

func end():
	get_tree().call_group("endGate", "check")
	
func actualEnd():
	if endCheck == 2:
		print("good") #signal end level here
		

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

func spawnObject(cords, dir):
	var pos = world_to_map(cords)
	var scene = load("res://scenes/Mirror.tscn")
	var secondMirror = load("res://scenes/GhostPortal.tscn")
	var portalObj = secondMirror.instance()
	var mirObject = scene.instance()
	portalObj.place(cords)
	mirObject.place(cords)
	portalObj.ChangeFace(dir)
	mirObject.ChangeFace(dir)
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
		if children[0].position == (startPos - Vector2(192, 0)):
			pos = children[1].position + Vector2(192,0)
		else:
			pos = children[0].position + Vector2(192,0)
		
		get_tree().call_group("ghost", "teleport", pos)
