extends Node2D

var attendees = []
const QUEUE_STARTING_POS = Vector2i(10,160)
var current_end = QUEUE_STARTING_POS


func enqueue(attendee):
	self.add_child(attendee)
	attendee.position = current_end
	attendees.append(attendee)
	current_end = Vector2i(current_end.x, current_end.y-20)
	
func dequeue():
	# TODO: remove from front, move everyone up
	pass
	
func get_attendee_count():
	return len(attendees)
