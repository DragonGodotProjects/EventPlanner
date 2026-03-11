extends GutTest

func test_adding_to_tables():
	var event = preload("res://event.tscn").instantiate()
	add_child_autofree(event)
	event.add_table()
	event.add_attendee()
	event.add_table()
	event.add_attendee()
	assert_eq()
	
