extends GutTest

func test_set_happiness():
	var attendee:Attendee = preload("res://attendee.tscn").instantiate()
	add_child_autofree(attendee) # gut should add and remove from scene tree
	attendee.happiness = 50
	assert_eq(attendee.happiness, 50)
	# check that the color setting worked
	assert_almost_eq(attendee.color_node.modulate.g, 1.0, 0.001)
	assert_almost_eq(attendee.color_node.modulate.a, 0.5, 0.001)
	
	attendee.happiness = -50
	assert_eq(attendee.happiness, -50)
	attendee.happiness = 100
	assert_eq(attendee.happiness, 100)
	attendee.happiness = -100
	assert_eq(attendee.happiness, -100)
	
	attendee.happiness = 3
	assert_eq(attendee.happiness, 3)
	attendee.happiness = 101
	assert_push_error("invalid value for happiness")
	assert_eq(attendee.happiness, 3) 
