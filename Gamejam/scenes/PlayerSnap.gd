extends Area2D

var tileSize = 16
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

var tiles = {"ice": 3,
			"button":4}
			
var oldDir = Vector2.UP

var mirrorsHeld = 0
var onMirror = false

onready var ray = $RayCast2D
onready var floorRay = $floorCheck
onready var tween = $Tween

export var speed = 3
export var selected = true


signal sendCords(cords)


# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tileSize)
	position += Vector2.ONE * tileSize/2
	
	
func receiveCords(id):
	#print(id)
	if selected:
		if tiles["ice"] == id:
			move(oldDir)
	#else if tiles["button"] == id:
	

func _process(delta):
	
	if Input.is_action_just_pressed("switch"):
			selected = !selected
	if tween.is_active() or !selected:
		return
	if Input.is_action_just_pressed("use"):
		if floorRay.is_colliding():
			var body = floorRay.get_collider()
			if body != null:
				if body.name != "TileMap":
					if("Mirror" in body.name ):
						#print(body.name)
						get_tree().call_group("map", "takeMirror")
						body.use()
					else:
						body.use()
	
	
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			oldDir = inputs[dir]
			move(inputs[dir])
			
	if Input.is_action_just_pressed("place") and mirrorsHeld > 0:
		mirrorsHeld = mirrorsHeld - 1
		get_tree().call_group("map", "spawnObject", (position))

func addMirror():
	mirrorsHeld = mirrorsHeld + 1

func move(dir):
	floorRay.cast_to = dir * tileSize
	ray.cast_to = dir * tileSize
	ray.force_raycast_update()
	floorRay.force_raycast_update()
	
	#emit_signal("sendCords",(position + dir * tileSize))
	if !ray.is_colliding():
#		position += inputs[dir] * tileSize
		move_tween(dir)
	#else :
	#	var name = ray.get_collider().name
	#	if "Mirror" in name:
	#		onMirror = true
	#		move_tween(dir)
	#put extraordinary blocks here
	
	

func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + dir * tileSize,
		1.0/speed, Tween.TRANS_LINEAR)
	tween.start()

	


func _on_Tween_tween_completed(object, key):
	get_tree().call_group("map", "sendCords", (position))


func _on_Area2D_area_entered(area):
	print("item")
	pass # Replace with function body.
