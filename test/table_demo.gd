extends Node2D

var rng = RandomNumberGenerator.new()

@onready var attendee_scene:PackedScene = preload("../attendee.tscn")
@onready var table:Table = $Table

func _input(event:InputEvent):
	if event.is_action_pressed("ui_up"):
		var new_attendee:Attendee = attendee_scene.instantiate()
		new_attendee.position = Vector2i(rng.randi_range(50, 400), rng.randi_range(50, 400))
		var seat_num = table.find_open_seat()
		if seat_num != -1:
			table.seat_attendee(new_attendee, seat_num)
		else:
			print("No seat available")
