extends Node2D


const table_locs = [Vector2i(57, 63), Vector2i(57, 144), Vector2i(108, 105), Vector2i(163, 61), Vector2i(157, 144)]
var tables = [null, null, null, null, null] #hold tables if they're in this position

@onready var attendee_scene = preload("attendee.tscn")
@onready var table_scene = preload("table.tscn")
@onready var waiting_queue = $WaitingQueue


func add_attendee():
	var new_attendee = attendee_scene.instantiate()
	var seated = false
	for table in tables:
		if table and table.seat_attendee(new_attendee):
			seated = true
	if not seated:
		waiting_queue.enqueue(new_attendee)
	
func add_table():
	var table = table_scene.instantiate()
	for idx in range(len(tables)):
		if tables[idx] == null:
			self.add_child(table)
			tables[idx] = table
			table.position = table_locs[idx]
			# TODO: need to walkt through queue and seat people
			return true
	return false
	
