class_name Event extends Node2D


const table_locs:Array[Vector2i] = [Vector2i(70, 63), Vector2i(80, 144), Vector2i(120, 105), Vector2i(185, 61), Vector2i(173, 144)]
var tables:Array[Table] = [null, null, null, null, null] # holds tables if they're in this position

@onready var attendee_scene:PackedScene = preload("attendee.tscn")
@onready var table_scene:PackedScene = preload("table.tscn")
@onready var waiting_queue:WaitingQueue = $WaitingQueue

func _ready():
	waiting_queue.dequeued.connect(_on_attendee_ready_to_sit)

func attendee_arrived() -> void :
	var new_attendee:Attendee = attendee_scene.instantiate()
	new_attendee.position = waiting_queue.entrance_node.position
	waiting_queue.start_enqueue(new_attendee)
	
func add_table() -> bool :
	var table:Table = table_scene.instantiate()
	for idx:int in range(len(tables)):
		if tables[idx] == null:
			self.add_child(table)
			tables[idx] = table
			table.position = table_locs[idx]
			return true
	return false
	
func _on_attendee_ready_to_sit(attendee:Attendee) -> void:
	var table_and_seat_num = _find_open_seat()
	if table_and_seat_num[0] != -1:
		tables[table_and_seat_num[0]].seat_attendee(attendee, table_and_seat_num[1])
	else:
		push_error("Can't seat with no available seat")

func _find_open_seat() -> Array[int]:
	for idx in range(len(tables)):
		if tables[idx] != null:
			var seat_num:int = tables[idx].find_open_seat()
			if seat_num != -1:
				return [idx, seat_num]
	return [-1, -1]
	
func try_to_seat_from_queue() -> bool:
	if waiting_queue.has_attendees() and _find_open_seat()[0] != -1:
		waiting_queue.start_dequeue()
		return true
	else:
		return false
	
	
func attendee_waiting_count() -> int:
	return waiting_queue.get_attendee_count()
	
func attendee_count() -> int :
	var total:int = attendee_waiting_count()
	for table in tables:
		if table != null:
			total += table.seated_count()
	return total
	
