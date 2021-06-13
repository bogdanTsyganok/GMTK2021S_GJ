extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation = $AnimatedSprite
onready var colider = $CollisionShape2D

export var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if open:
		animation.play("open")
		animation.set_frame(15)
		colider.disabled = open
	pass # Replace with function body.

func open():
	if colider.disabled:
		animation.play("open", true)
	else:
		animation.play("open")
	colider.disabled = !colider.disabled
	
func use():
	print("knock knock")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
