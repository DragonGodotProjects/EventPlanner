extends Node2D

@onready var attendee_scene:PackedScene = preload("../attendee.tscn")
@onready var table1:Table = $Table

func _input(event):
	if event.is_action_pressed("ui_up"):
		var new_attendee:Attendee = attendee_scene.instantiate()
		print(table1.seat_attendee(new_attendee))
