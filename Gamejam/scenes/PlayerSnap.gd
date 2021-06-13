extends Area2D

var tileSize = 16
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

var tiles = {"ice": 5,
			"button":22}
			
var oldDir = Vector2.UP

var mirrorsHeld = 0
var onMirror = false

onready var ray = $RayCast2D
onready var floorRay = $floorCheck
onready var tween = $Tween

onready var animation = $AnimatedSprite
onready var player = $AnimationPlayer

export var speed = 3
export var selected = true

var onIce = false

signal sendCords(cords)


# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tileSize)
	position += Vector2.ONE * tileSize/2
	
	
func receiveCords(id):
	#print(id)
	if selected:
		if tiles["ice"] == id:
			onIce = true
			move(oldDir)
		else:
			onIce = false
		get_tree().call_group("ghost", "switched", onIce)
	#else if tiles["button"] == id:
	

func _process(delta):
	
	if Input.is_action_just_pressed("switch") and !onIce:
			selected = !selected
			get_tree().call_group("ghost", "switched", onIce)
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
			
			if oldDir == Vector2.LEFT:
				animation.flip_h = false
			elif oldDir == Vector2.RIGHT:
				animation.flip_h = true
			
			if oldDir == Vector2.UP:
				animation.play("walk_v")
			else :
				animation.play("walk_h")
			
			player.play("bobbing")
			
			move(inputs[dir])
			
	if Input.is_action_just_pressed("place") and mirrorsHeld > 0:
		if ray.is_colliding():
			var colBody = ray.get_collider()
			print(colBody.name)
			if colBody.name == "TileMap":
				mirrorsHeld = mirrorsHeld - 1
				get_tree().call_group("map", "spawnObject", position, oldDir)
				get_tree().call_group("mirrorCounter", "updateMirrorText", str(mirrorsHeld))

func addMirror():
	mirrorsHeld = mirrorsHeld + 1
	get_tree().call_group("mirrorCounter", "updateMirrorText", str(mirrorsHeld))

func move(dir):
	floorRay.cast_to = dir * tileSize
	ray.cast_to = dir * tileSize
	ray.force_raycast_update()
	floorRay.force_raycast_update()
	
	#emit_signal("sendCords",(position + dir * tileSize))
	if !ray.is_colliding():
#		position += inputs[dir] * tileSize
		move_tween(dir)
	else:
		onIce = false
		animation.stop()
	
	

func move_tween(dir):
	animation.play()
	tween.interpolate_property(self, "position",
		position, position + dir * tileSize,
		1.0/speed, Tween.TRANS_LINEAR)
	tween.start()

	


func _on_Tween_tween_completed(object, key):
	get_tree().call_group("map", "sendCords", position)
	animation.stop()


func _on_Area2D_area_entered(area):
	print("item")
	pass # Replace with function body.
