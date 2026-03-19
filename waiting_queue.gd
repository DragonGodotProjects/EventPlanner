class_name WaitingQueue extends Node2D

signal dequeued(attendee:Attendee)
signal enqueued(attendee:Attendee)
signal queue_moved

const LINE_SPACING:int = 20

var attendees:Array[Attendee] = []
@onready var entrance_node:Node2D = $Entrance
@onready var front_node:Node2D = $Front
@onready var start_pos:Vector2i = front_node.position
@onready var end_pos:Vector2i = start_pos

func has_attendees() -> bool:
	return not attendees.is_empty()

func start_enqueue(attendee:Attendee) -> void:
	self.add_child(attendee)
	attendees.append(attendee)
	var curr_pos:Vector2i = end_pos
	end_pos = Vector2i(end_pos.x, end_pos.y-LINE_SPACING)
	var end_enqueue:Callable = func():
		enqueued.emit(attendee)
	attendee.walk_to(curr_pos, end_enqueue)
	
	
	
func start_dequeue() -> bool:
	if len(attendees) > 0:
		var attendee_out:Attendee = attendees.pop_front()
		# closure to bring attendee_out with function
		var end_dequeue = func():
			#print("dequeue done")
			remove_child(attendee_out)
			dequeued.emit(attendee_out)
			_move_everyone_up_from_index(0, start_pos)
		attendee_out.walk_to(Vector2(attendee_out.position.x, attendee_out.position.y+LINE_SPACING), end_dequeue)
		return true
	else:
		return false
	
	
func _move_everyone_up_from_index(currIdx:int, next_pos:Vector2i):
	if (currIdx < len(attendees)):
		#print("moving " + str(currIdx)+ " out of " + str(len(attendees)) + " to " + str(next_pos))
		var next = func(): _move_everyone_up_from_index(currIdx+1, next_pos - Vector2i(0, LINE_SPACING))
		attendees[currIdx].walk_to(next_pos, next)
	else:
		end_pos = Vector2i(end_pos.x, end_pos.y+LINE_SPACING)
		queue_moved.emit()
	
func get_attendee_count():
	return len(attendees)
