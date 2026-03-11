extends Node2D


@onready var attendee_scene = preload("../attendee.tscn")
@onready var waiting_queue = $WaitingQueue

func _input(event):
	if event.is_action_pressed("ui_up"):
		var new_attendee = attendee_scene.instantiate()
		waiting_queue.enqueue(new_attendee)
