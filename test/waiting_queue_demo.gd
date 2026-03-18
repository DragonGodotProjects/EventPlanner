extends Node2D

var rng = RandomNumberGenerator.new()
@onready var attendee_scene:PackedScene = preload("../attendee.tscn")
@onready var waiting_queue:WaitingQueue = $WaitingQueue

func _ready():
	waiting_queue.dequeued.connect(on_finish_dequeue)
	waiting_queue.enqueued.connect(on_finish_enqueue)

func _input(event:InputEvent):
	if event.is_action_pressed("ui_up"):
		var new_attendee:Attendee = attendee_scene.instantiate()
		waiting_queue.start_enqueue(new_attendee)
	elif event.is_action_pressed("ui_down"):
		waiting_queue.start_dequeue()
		
func on_finish_enqueue(attendee:Attendee):
	attendee.happiness = -50
	
func on_finish_dequeue(attendee:Attendee):
	add_child(attendee)
	attendee.happiness = 50
	attendee.walk_to(Vector2i(rng.randi_range(50, 400), rng.randi_range(50, 400)))
	
