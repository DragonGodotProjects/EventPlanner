extends Node2D

@onready var color_node = $Color

@export var happiness:int = 0:
	set(new_value):
		assert (new_value >=-100 and new_value <= 100)
		happiness = new_value
		if happiness > 0:
			color_node.modulate = Color(0, 1, 0, happiness/100.0)
		elif happiness < 0:
			color_node.modulate = Color(1, 0, 0, -happiness/100.0)
