extends GutTest

func test_only_waiting_queue():
	var event = preload("res://event.tscn").instantiate()
	add_child_autofree(event)
	
	for i in range(10):
		assert_eq(event.attendee_count(), i)
		event.add_attendee()
		assert_eq(event.attendee_count(), i+1)

func test_adding_to_tables():
	var event = preload("res://event.tscn").instantiate()
	add_child_autofree(event)
	event.add_table()
	event.add_attendee()
	event.add_table()
	event.add_attendee()
	
