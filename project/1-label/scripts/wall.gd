extends StaticBody2D

func _ready():
	var sprite_copy = self.duplicate(1)
	get_parent().add_child.call_deferred(sprite_copy)
	sprite_copy.position = Vector2(get_node("/root/Main").window_size.x - self.position.x, self.position.y)
	sprite_copy.rotation = -rotation
	sprite_copy.scale.x = -1
