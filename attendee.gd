class_name Attendee extends Node2D

signal attendee_exited(attendee:Attendee)

static var NEXT_ID=1


@onready var happiness_change_timer:Timer = null
@onready var curr_happiness_change:int = 0

@onready var color_node:Sprite2D = $Color
@onready var label:Label = $Label

func _ready() -> void:
	id = NEXT_ID
	NEXT_ID += 1

@export var id:int = 1:
	set(new_value):
		id = new_value
		label.text = str(new_value)

static func is_valid_happiness(new_value):
	return new_value >=-100 and new_value <= 100

@export var happiness:int = 0:
	set(new_value):
		if is_valid_happiness(new_value):
			happiness = new_value
			if happiness > 0:
					color_node.modulate = Color(0, 1, 0, happiness/100.0)
			elif happiness < 0:
				color_node.modulate = Color(1, 0, 0, -happiness/100.0)
		else:
			push_error("invalid value for happiness:"+str(new_value))

func leave(exit_location:Vector2):
	walk_to(to_local(exit_location), func on_exit(): attendee_exited.emit(self))

func walk_to(new_pos:Vector2, callback=null):
	# compute distance to find speed of movement
	var distance:float = self.position.distance_to(new_pos)
	var tween = get_tree().create_tween()
	# move 150 pixels per second
	tween.tween_property(self, "position", new_pos, distance/150)
	if callback:
		tween.tween_callback(callback)

func _on_happiness_timer():
	print("happiness timer")
	if (is_valid_happiness(happiness+curr_happiness_change)):
		happiness+=curr_happiness_change

func start_happiness_timer(delta:int, wait_time:float):
	print("Starting timer")
	curr_happiness_change = delta
	happiness_change_timer = Timer.new()
	happiness_change_timer.wait_time = wait_time
	happiness_change_timer.timeout.connect(_on_happiness_timer)
	add_child(happiness_change_timer)
	happiness_change_timer.start()
	
func clear_happiness_timer():
	happiness_change_timer.queue_free()
	happiness_change_timer = null
	curr_happiness_change = 0
	
