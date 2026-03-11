extends Node2D

@onready var catered_event = $Event

func _input(input_event):
	if input_event.is_action_pressed("ui_up"):
		catered_event.add_attendee()
	elif input_event.is_action_pressed("ui_down"):
		catered_event.add_table()
