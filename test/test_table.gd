extends GutTest

func test_find_and_seat():
	var attendee_scene:PackedScene = preload("res://attendee.tscn")
	var table:Table = preload("res://table.tscn").instantiate()
	add_child_autofree(table) # gut should add and remove the table
	
	for i in range(4):
		assert_eq(table.seated_count(), i)
		var next_attendee:Attendee = attendee_scene.instantiate()
		autofree(next_attendee) # table will add but not remove attendee, since the test made it
		var seat_num = table.find_open_seat()
		table.seat_attendee(next_attendee, seat_num)
		assert_eq(table.seated_count(), i+1)
		
	
	var no_seat_attendee:Attendee = attendee_scene.instantiate()
	autofree(no_seat_attendee) # table will add but not remove attendee, since the test made it
	for i in range(3):
		assert_eq(table.seated_count(), 4)
		assert_eq( table.find_open_seat(), -1)
		assert_eq(table.seated_count(), 4)
		table.seat_attendee(no_seat_attendee, i)
		assert_push_error("seat not available: seat num " + str(i))
