extends Node2D

@onready var catered_event:Event = $Event

func _input(input_event:InputEvent) -> void:
	if input_event.is_action_pressed("ui_up"):
		catered_event.attendee_arrived()
	elif input_event.is_action_pressed("ui_down"):
		catered_event.add_table()
	elif input_event.is_action_pressed("ui_left"):
		print (catered_event.try_to_seat_from_queue())
