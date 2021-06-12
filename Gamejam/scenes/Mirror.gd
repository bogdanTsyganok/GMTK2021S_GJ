extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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


func _on_Area2D_area_entered(area):
	print("hello")
	pass # Replace with function body.
