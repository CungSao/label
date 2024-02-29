extends Node

@export var window_size = Vector2i(720, 540)
@export var mob_scene:PackedScene

func _ready():
	set_screen(window_size)
	
func set_screen(size, pos_x = 0.6, pos_y = 0.33):
	#window
	DisplayServer.window_set_size(size)
	DisplayServer.window_set_position(Vector2i(size.x*pos_x, size.y*pos_y))
	#content
	get_tree().root.content_scale_size = size
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()

	var mob_spawn_location = get_node("SpawnPath3D/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	mob_spawn_location.position.y = 1
	mob.initialize(mob_spawn_location.position, $Player.position)

	add_child(mob)
