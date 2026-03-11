extends GutTest

var event

func before_each():
	event = preload("res://event.tscn").instantiate()
	add_child_autofree(event)

func test_only_waiting_queue():
	for i in range(10):
		assert_eq(event.attendee_count(), i)
		event.add_attendee()
		assert_eq(event.attendee_count(), i+1)
	
	

func test_adding_to_tables():
	event.add_table()
	event.add_attendee()
	event.add_table()
	event.add_attendee()
	
