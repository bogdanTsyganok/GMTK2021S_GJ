extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var count = 0

var entity1
var entity2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func swap():
	if count >= 2:
		print("swap")
		var temp = entity1.position
		entity1.position = entity2.position
		entity2.position = temp
		
func _process(delta):
	if Input.is_action_just_pressed("use"):
		swap()


func _on_Portal1_area_entered(area):
	entity1 = area
	count = count + 1
	

func _on_Portal1_area_exited(area):
	count = count - 1
	


func _on_Portal2_area_entered(area):
	entity2 = area
	count = count + 1


func _on_Portal2_area_exited(area):
	count = count - 1
