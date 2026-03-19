extends GutTest

var attendee_scene:PackedScene = preload("res://attendee.tscn")
var q:WaitingQueue

func before_each():
	Attendee.NEXT_ID = 1
	q = preload("res://waiting_queue.tscn").instantiate()
	add_child_autofree(q) # gut should add and remove

func test_enqueue():
	helper_add_and_check_attendees(5)
	var ids:Array = range(5)
	# check that all signals with correct attendees are received
	for i in range(5):
		assert_true (await wait_for_signal(q.enqueued, 3)) # wait for signal calls watch_signal, which allows get_signal_parameters to work
		var a_in:Attendee = get_signal_parameters(q.enqueued)[0]
		# convert to 0-4 rather than 1-5
		if ids[a_in.id-1] == a_in.id-1:
			ids[a_in.id-1] = -1
		else:
			fail_test("Repeated id: " + str(a_in.id))
	for id in ids:
		if id != -1:
			fail_test("attendee never signaled: " + str(id))
			

func test_dequeue_on_empty():
	assert_false(q.start_dequeue())
	helper_add_and_check_attendees(3)
	for num in range(3):
		assert_true(q.start_dequeue())
		assert_true (await wait_for_signal(q.dequeued, 3))
	assert_false(q.start_dequeue())

func test_both_enqueue_and_dequeue():
	# put some attendees in the queue
	helper_add_and_check_attendees(4)
	# wait for them all to enqueue
	for i in range(4):
		assert_true (await wait_for_signal(q.enqueued, 3))
	
	# take someone out
	assert_true(q.start_dequeue())
	# wait for them to move out of queue
	assert_true (await wait_for_signal(q.dequeued, 3)) # wait for signal calls watch_signal, which allows get_signal_parameters to work
	var first_out:Attendee = get_signal_parameters(q.dequeued)[0]
	assert_eq(first_out.id, 1)
	assert_eq(first_out.get_parent(), null)
	assert_eq(first_out.position, Vector2(q.start_pos.x, q.start_pos.y + q.LINE_SPACING))
	assert_eq(q.get_attendee_count(), 3)
	
	# wait for eveyone in line to move up
	assert_true (await wait_for_signal(q.queue_moved, 3))
	assert_eq(q.attendees[0].id, 2)
	assert_eq(q.attendees[0].position, q.front_node.position)
	assert_eq(q.attendees[-1].id, 4)
	assert_eq(q.attendees[-1].position, Vector2(q.end_pos.x, q.end_pos.y + q.LINE_SPACING))

func test_dequeue_while_moving():
	# many people in line
	helper_add_and_check_attendees(8)
	# dequeue multiple quickly so one is dequeued while the queue is still updating
	assert_true(q.start_dequeue())
	assert_true(q.start_dequeue())
	assert_true (await wait_for_signal(q.queue_moved, 3))
	assert_eq (await get_signal_emit_count(q.queue_moved), 2)
	# people should be in proper position
	assert_eq(q.attendees[0].id, 3)
	assert_eq(q.attendees[0].position, q.front_node.position)
	assert_eq(q.attendees[-1].id, 8)
	assert_eq(q.attendees[-1].position, Vector2(q.front_node.position.x, q.front_node.position.y - (5*q.LINE_SPACING))) 
	assert_eq(q.attendees[-1].position, Vector2(q.end_pos.x, q.end_pos.y + q.LINE_SPACING))


func helper_add_and_check_attendees(num_to_add):
	# put some attendees in the queue
	for i in range(num_to_add):
		assert_eq(q.get_attendee_count(), i)
		var next_attendee:Attendee = attendee_scene.instantiate()
		next_attendee.position = q.entrance_node.position
		autofree(next_attendee) # table will add but not remove attendee, since the test made it
		q.start_enqueue(next_attendee)
		assert_eq(q.get_attendee_count(), i+1)
	
	
