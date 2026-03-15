class_name WaitingQueue extends Node2D

signal dequeued(attendee:Attendee)
signal queue_moved

const LINE_SPACING:int = 20

var attendees:Array[Attendee] = []
@onready var front_node:Node2D = $Front
@onready var start_pos:Vector2i = front_node.position
@onready var end_pos:Vector2i = start_pos

func has_attendees() -> bool:
	return not attendees.is_empty()

func enqueue(attendee):
	self.add_child(attendee)
	attendee.position = end_pos
	attendees.append(attendee)
	end_pos = Vector2i(end_pos.x, end_pos.y-LINE_SPACING)
	
	
func start_dequeue() -> bool:
	if len(attendees) > 0:
		var attendee_out:Attendee = attendees.pop_front()
		# closure to bring attendee_out with function
		var end_dequeue = func(): 
			remove_child(attendee_out)
			dequeued.emit(attendee_out)
			move_everyone_from_index(0)
		move_up_one(attendee_out, end_dequeue)
		return true
	else:
		return false
	
	
func move_everyone_from_index(currIdx):
	if (currIdx < len(attendees)):
		move_up_one(attendees[currIdx], func next(): move_everyone_from_index(currIdx+1))
	else:
		end_pos = Vector2i(end_pos.x, end_pos.y+LINE_SPACING)
		queue_moved.emit()
	
func get_attendee_count():
	return len(attendees)

static func move_up_one(attendee:Attendee, callback:Callable):
	attendee.walk_to(Vector2(attendee.position.x, attendee.position.y+LINE_SPACING), callback)
