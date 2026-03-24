extends Node2D

@onready var seat = $Seat

func _input(event:InputEvent):
	if event.is_action_pressed("ui_up"):
		seat.direction = Vector2i.UP
	elif event.is_action_pressed("ui_down"):
		seat.direction = Vector2i.DOWN
	# error condition currently
	elif event.is_action_pressed("ui_right"):
		seat.direction = Vector2i.RIGHT
