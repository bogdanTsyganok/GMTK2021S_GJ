extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var full

func use():
	get_tree().call_group("map", "end")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func check():
	if full != null:
		get_tree().call_group("map", "actualEnd")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HEnd_area_entered(area):
	full = area
	get_tree().call_group("map", "addToEnd")


func _on_HEnd_area_exited(area):
	full = null
	get_tree().call_group("map", "subFromEnd")
	
