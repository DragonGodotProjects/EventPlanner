extends GutTest

var event:Event

func before_each():
	event = preload("res://event.tscn").instantiate()
	add_child_autofree(event)

func test_only_waiting_queue():
	for i in range(10):
		assert_eq(event.attendee_count(), i)
		event.add_attendee()
		assert_eq(event.attendee_count(), i+1)
	

func test_filling_several_tables_and_some_queue():
	event.add_table()
	event.add_attendee()
	event.add_table()
	event.add_attendee()
	assert_eq(event.attendee_count(), 2)
	assert_eq(event.attendee_waiting_count(), 0)
	for i in range(10):
		event.add_attendee()
	assert_eq(event.attendee_count(), 12)
	assert_eq(event.attendee_waiting_count(), 4)

	
