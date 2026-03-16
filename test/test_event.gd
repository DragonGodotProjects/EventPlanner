extends GutTest

var event:Event

func before_each():
	event = preload("res://event.tscn").instantiate()
	add_child_autofree(event)

func test_only_waiting_queue():
	helper_add_attendees_to_q_and_check(10)

func test_filling_several_tables_and_some_queue():
	event.add_table()
	event.add_table()
	helper_add_attendees_to_q_and_check(10)
	assert_eq(event.attendee_count(), 10)
	assert_eq(event.attendee_waiting_count(), 10)
	# room for 8 people currently
	for i in range(8):
		assert_true(event.try_to_seat_from_queue())
		assert_true(await wait_for_signal(event.waiting_queue.dequeued, 3))
		# one person has been seated (hence i+1)
		assert_eq(event.attendee_waiting_count(), 10-(i+1))
	
	assert_eq(event.attendee_waiting_count(), 2)
	# try a bunch of times to seat people that don't have seats
	for i in range(5):
		assert_false(event.try_to_seat_from_queue())
		assert_eq(event.attendee_count(), 10)
		assert_eq(event.attendee_waiting_count(), 2)
	
func helper_add_attendees_to_q_and_check(num_to_add):
	for i in range(num_to_add):
		assert_eq(event.attendee_count(), i)
		event.attendee_arrived()
		assert_eq(event.attendee_count(), i+1)
