extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var animationFrame = $AnimatedSprite

func place(cords):
	position += (Vector2(192, 0))

func use():
	pass

func ChangeFace(direction):
	if direction == Vector2.UP:
		$AnimatedSprite.set_frame(0)
	else: if direction == Vector2.DOWN:
		$AnimatedSprite.set_frame(1)
	else: if direction == Vector2.LEFT:
		$AnimatedSprite.set_frame(2)
	else: if direction == Vector2.RIGHT:
		$AnimatedSprite.set_frame(3)
