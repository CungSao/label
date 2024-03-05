extends Node2D

var Ball = load("res://project/6_area/Ball.tscn")
var colors = {
	"gray": Color(1, 1, 1, 0.1),
	"green": Color(1, 1, 0, 0.1),
	"blue": Color(0, 1, 1, 0.1)
}

func _draw():
	draw_circle($Point.position, $Point/CollisionShape2D.shape.radius, colors.gray)
	var s = $Antigrav/CollisionShape2D.shape.size
	draw_rect(Rect2($Antigrav.position - (s / 2), s), colors.green)
	s = $Slow/CollisionShape2D.shape.size
	draw_rect(Rect2($Slow.position - (s / 2), s), colors.blue)
	
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var b = Ball.instantiate()
			b.position = event.position
			add_child(b)
