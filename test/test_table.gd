extends GutTest

func test_seated_count():
	var attendee_scene = preload("res://attendee.tscn")
	var table = preload("res://table.tscn").instantiate()
	add_child_autofree(table) # gut should add and remove the table
	
	for i in range(4):
		assert_eq(table.seated_count(), i)
		var next_attendee = attendee_scene.instantiate()
		autofree(next_attendee) # table will add but not remove attendee, since the test made it
		var seated = table.seat_attendee(next_attendee)
		assert_true(seated)
		assert_eq(table.seated_count(), i+1)
	
	for i in range(3):
		assert_eq(table.seated_count(), 4)
		var next_attendee = attendee_scene.instantiate()
		autofree(next_attendee) # table will add but not remove attendee, since the test made it
		var seated = table.seat_attendee(next_attendee)
		assert_false(seated)
		assert_eq(table.seated_count(), 4)
