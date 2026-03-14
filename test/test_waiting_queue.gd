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
	
	
	var first_out:Attendee = q.dequeue()
	# assert_eq(first_out.id, 1)
	fail_test("Not implemented yet")
	
	
