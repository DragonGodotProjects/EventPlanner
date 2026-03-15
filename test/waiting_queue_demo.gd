extends Node2D


@onready var attendee_scene:PackedScene = preload("../attendee.tscn")
@onready var waiting_queue:WaitingQueue = $WaitingQueue

func _input(event:InputEvent):
	if event.is_action_pressed("ui_up"):
		var new_attendee:Attendee = attendee_scene.instantiate()
		waiting_queue.enqueue(new_attendee)
	elif event.is_action_pressed("ui_down"):
		waiting_queue.dequeued.connect(on_finish_dequeue)
		waiting_queue.start_dequeue()
		
func on_finish_dequeue(attendee:Attendee):
	add_child(attendee)
	attendee.happiness = 50
