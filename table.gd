class_name Table extends Node2D

const seat_loc:Array[Vector2i] = [Vector2i(-16, -20), Vector2i(8, -20), Vector2i(-16, 10), Vector2i(8, 10)]
var chairs:Array[Attendee] = [null, null, null, null] # holds attendees if they are sitting in this chair

func seat_attendee(attendee:Attendee) -> bool:
	for  idx:int in range(len(chairs)):
		if chairs[idx] == null:
			self.add_child(attendee)
			chairs[idx] = attendee
			attendee.position = seat_loc[idx]
			return true
	return false
			
func seated_count() -> int:
	return len(seat_loc)-chairs.count(null)
	
	
