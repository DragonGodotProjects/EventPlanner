extends GutTest

func test_enqueue_dequeue():
	Attendee.NEXT_ID = 1
	var attendee_scene:PackedScene = preload("res://attendee.tscn")
	var q:WaitingQueue = preload("res://waiting_queue.tscn").instantiate()
	add_child_autofree(q) # gut should add and remove
	
	for i in range(4):
		assert_eq(q.get_attendee_count(), i)
		var next_attendee:Attendee = attendee_scene.instantiate()
		autofree(next_attendee) # table will add but not remove attendee, since the test made it
		q.enqueue(next_attendee)
		assert_eq(q.get_attendee_count(), i+1)
	
	q.start_dequeue()
	assert_true (await wait_for_signal(q.dequeued, 3)) # wait for signal calls watch_signal, which allows get_signal_parameters to work
	var first_out:Attendee = get_signal_parameters(q.dequeued)[0]
	assert_eq(first_out.id, 1)
	assert_eq(first_out.get_parent(), null)
	assert_eq(first_out.position, Vector2(q.start_pos.x, q.start_pos.y + q.LINE_SPACING))
	
	
	
	
