extends StaticBody2D

var sprite_copy
func _ready():
	sprite_copy = self.duplicate(1)
	$"..".add_child.call_deferred(sprite_copy)
	sprite_copy.position = Vector2(get_viewport_rect().size.x - self.position.x, self.position.y)
	sprite_copy.rotation = -rotation
	sprite_copy.scale.x = -1
