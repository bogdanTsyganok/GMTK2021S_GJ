extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var animationFrame = 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func use():
	print("mirror")
	get_tree().call_group("player", "addMirror")
	queue_free()
	
func place(var pos):
	position += pos
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func ChangeFace(direction):
	if direction == Vector2.UP:
		$AnimatedSprite.set_frame(0)
	else: if direction == Vector2.DOWN:
		$AnimatedSprite.set_frame(1)
	else: if direction == Vector2.LEFT:
		$AnimatedSprite.set_frame(2)
	else: if direction == Vector2.RIGHT:
		$AnimatedSprite.set_frame(3)

func _on_Area2D_area_entered(area):
	print("hello")
	pass # Replace with function body.
	
	
