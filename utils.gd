extends Node

func set_pos_screen(size, pos_x = 0.6, pos_y = 0.33):
	#window
	DisplayServer.window_set_size(size)
	DisplayServer.window_set_position(Vector2i(size.x*pos_x, size.y*pos_y))
	#content
	get_tree().root.content_scale_size = size
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
