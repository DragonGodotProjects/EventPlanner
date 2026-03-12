class_name Event extends Node2D


const table_locs:Array[Vector2i] = [Vector2i(57, 63), Vector2i(57, 144), Vector2i(108, 105), Vector2i(163, 61), Vector2i(157, 144)]
var tables:Array[Table] = [null, null, null, null, null] # holds tables if they're in this position

@onready var attendee_scene:PackedScene = preload("attendee.tscn")
@onready var table_scene:PackedScene = preload("table.tscn")
@onready var waiting_queue:WaitingQueue = $WaitingQueue


func add_attendee() -> void :
	var new_attendee:Attendee = attendee_scene.instantiate()
	var seated:bool = seat_attendee(new_attendee)
	if not seated:
		waiting_queue.enqueue(new_attendee)
	
func add_table() -> bool :
	var table:Table = table_scene.instantiate()
	for idx:int in range(len(tables)):
		if tables[idx] == null:
			self.add_child(table)
			tables[idx] = table
			table.position = table_locs[idx]
			# TODO: need to walkt through queue and seat people
			return true
	return false
	
func try_to_seat_queue():
	# TODO
	pass 
	
func seat_attendee(attendee:Attendee) -> bool:
	for table in tables:
		if table != null and table.seat_attendee(attendee):
			# if table.seatAttendee() returned true, they got a seat
			return true
	# if we make it here, there are no seats
	return false
	
func attendee_waiting_count() -> int:
	return waiting_queue.get_attendee_count()
	
func attendee_count() -> int :
	var total:int = attendee_waiting_count()
	for table in tables:
		if table != null:
			total += table.seated_count()
	return total
	
