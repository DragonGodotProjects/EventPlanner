extends Sprite2D

@export var happiness:int:
	set(new_value):
		assert (new_value >=-100 and new_value <= 100)
		happiness = new_value
		if happiness > 0:
			self.modulate = Color(0, happiness/100.0, 0)
		elif happiness < 0:
			self.modulate = Color(-happiness/100.0, 0, 0)
