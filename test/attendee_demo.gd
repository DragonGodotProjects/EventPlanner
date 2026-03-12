extends Node2D

@onready var attendee:Attendee = $Attendee

func _input(event:InputEvent):
	if event.is_action_pressed("ui_up"):
		attendee.happiness += 10
	elif event.is_action_pressed("ui_down"):
		attendee.happiness -= 10
	elif event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.is_released():
			attendee.walk_to(mouse_event.position, func finish(): print("Done moving") )
	
