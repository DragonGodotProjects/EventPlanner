class_name Attendee extends Node2D

static var NEXT_ID=1

@onready var color_node:Sprite2D = $Color
@onready var label:Label = $Label

func _ready() -> void:
	id = NEXT_ID
	NEXT_ID += 1

@export var id:int = 1:
	set(new_value):
		id = new_value
		label.text = str(new_value)

@export var happiness:int = 0:
	set(new_value):
		if (new_value >=-100 and new_value <= 100):
			happiness = new_value
			if happiness > 0:
					color_node.modulate = Color(0, 1, 0, happiness/100.0)
			elif happiness < 0:
				color_node.modulate = Color(1, 0, 0, -happiness/100.0)
		else:
			push_error("invalid value for happiness:"+str(new_value))

func walk_to(new_pos:Vector2, callback):
	# compute distance to find speed of movement
	var distance:float = self.position.distance_to(new_pos)
	var tween = get_tree().create_tween()
	# move 150 pixels per second
	tween.tween_property(self, "position", new_pos, distance/150)
	tween.tween_callback(callback)
