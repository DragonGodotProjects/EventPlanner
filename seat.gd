extends Node2D

const sprite_map: Dictionary[Vector2i, Texture2D] = {
	Vector2i.DOWN: preload("res://chair_front_down.png"),
	Vector2i.UP: preload("res://chair_front_up.png"),
}

var seat_sprite:Sprite2D

func _ready():
	seat_sprite = $SeatSprite

@export var direction:Vector2i = Vector2i.DOWN:
	set(new_direction):
		if (new_direction in sprite_map):
			seat_sprite.texture = sprite_map[new_direction]
		else:
			push_error("invalid value for new_direction:"+str(new_direction))
