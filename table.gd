class_name Table extends Node2D

const seat_loc:Array[Vector2i] = [Vector2i(-16, -20), Vector2i(8, -20), Vector2i(-16, 10), Vector2i(8, 10)]
var chairs:Array[Attendee] = [null, null, null, null] # holds attendees if they are sitting in this chair

func seat_attendee(attendee:Attendee, seat_num:int) -> void:
	if chairs[seat_num] == null:
		var attendee_global_pos = attendee.global_position
		self.add_child(attendee)
		attendee.global_position = attendee_global_pos
		chairs[seat_num] = attendee
		attendee.walk_to(seat_loc[seat_num])
	else:
		push_error("seat not available: seat num " + str(seat_num))
	
func find_open_seat() -> int:
	for  idx:int in range(len(chairs)):
		if chairs[idx] == null:
			return idx
	return -1
	
func seated_count() -> int:
	return len(seat_loc)-chairs.count(null)
	
	
