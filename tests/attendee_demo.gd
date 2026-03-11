extends Node2D


func _input(event):
	if event.is_action_pressed("ui_up"):
		$Attendee.happiness += 10
	elif event.is_action_pressed("ui_down"):
		$Attendee.happiness -= 10
