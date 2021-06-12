extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animation = $AnimatedSprite

export var doorName = ""
export var useable = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func use():
	if useable: 
		print(doorName)
		animation.play("used")
		#get_tree().call_group(door,"open")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
