class_name WaitingQueue extends Node2D

@export var start_pos:Vector2i = Vector2i(10,160)
var end_pos:Vector2i = start_pos
var attendees:Array[Attendee] = []

func has_attendees() -> bool:
	return not attendees.is_empty()

func enqueue(attendee):
	self.add_child(attendee)
	attendee.position = end_pos
	attendees.append(attendee)
	end_pos = Vector2i(end_pos.x, end_pos.y-20)
	
func dequeue():
	# TODO: remove from front, move everyone up
	pass
	
func get_attendee_count():
	return len(attendees)
