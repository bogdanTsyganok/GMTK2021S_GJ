extends Area2D

var tileSize = 16
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

#these will be different
var tiles = {"ice": 7,
			"button":4}
			

var oldDir = Vector2.UP

var rng = RandomNumberGenerator.new()

onready var ray = $RayCast2D
onready var floorRay = $FloorCheck

onready var animation = $AnimatedSprite

onready var tween = $Tween

export var speed = 3
export var selected = false
signal sendCords(cords)

var canSwitch = true

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tileSize)
	position += Vector2.ONE * tileSize/2
	
	
func receiveCords(id):
	if selected:
		if tiles["ice"] == id:
			move(oldDir)
	#else if tiles["button"] == id:
		

func switched(onIce):
	canSwitch = !onIce

func _process(delta):
	if Input.is_action_just_pressed("switch") and canSwitch:
			selected = !selected
	if tween.is_active() or !selected:
		return
	
	if Input.is_action_just_pressed("use"):
		if floorRay.is_colliding():
			var body = floorRay.get_collider()
			if "Portal" in body.name:
				get_tree().call_group("map","teleport", position)
			else:
				animation.play("use" + str(rng.randi_range(1,3)))
				body.use()
	
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			oldDir = inputs[dir]
			move(inputs[dir])
			
	if oldDir == Vector2.LEFT:
		animation.flip_h = false
	elif oldDir == Vector2.RIGHT:
		animation.flip_h = true
		
	if oldDir == Vector2.UP:
		animation.play("virtical")
		animation.flip_h = false
	else :
		animation.play("horizontal")

func move(dir):
	ray.cast_to = dir* tileSize
	ray.force_raycast_update()
	floorRay.cast_to = dir* tileSize
	floorRay.force_raycast_update()
	
	#emit_signal("sendCords",(position + dir * tileSize))
	if !ray.is_colliding():
#		position += inputs[dir] * tileSize
		move_tween(dir)
	#else :
	#	var name = ray.get_collider().name
	#	if name != "Player" and name != "TileMap":
	#		move_tween(dir)
			
	#get_tree().call_group("map", "sendCords", (position + dir * tileSize))
	

func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + dir * tileSize,
		1.0/speed, Tween.TRANS_LINEAR)
	tween.start()

func teleport(pos):
	position = pos


func _on_Tween_tween_completed(object, key):
	get_tree().call_group("map", "sendCords", (position))



