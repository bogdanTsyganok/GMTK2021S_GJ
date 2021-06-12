extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation = $AnimatedSprite
onready var colider = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func open():
	animation.play()
	colider.disabled = true
	
func use():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
