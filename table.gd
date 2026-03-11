extends Node2D

const seat_loc = [Vector2i(-20, -20), Vector2i(0, -20), Vector2i(-20, 10), Vector2i(0, 10)]
var chairs = [null, null, null, null] # holds attendees if they are sitting in this chair

func seat_attendee(attendee):
	for  idx in range(len(chairs)):
		if chairs[idx] == null:
			self.add_child(attendee)
			chairs[idx] = attendee
			attendee.position = seat_loc[idx]
			return true
	return false
			
func seated_count():
	return len(seat_loc)-chairs.count(null)
	
	
