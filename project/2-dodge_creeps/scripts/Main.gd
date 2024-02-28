extends Node

@export var window_size = Vector2i(480, 720)
@export var mob_scene:PackedScene

var score = 0

func _ready():
	new_game()
	set_screen()
	
func set_screen():
	#window
	DisplayServer.window_set_size(window_size)
	DisplayServer.window_set_position(Vector2i(window_size.x*1.1, window_size.y*0.15))
	#content
	get_tree().root.content_scale_size = window_size
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPos.position)
	$StartTimer.start()

func _on_score_timer_timeout():
	score += 1

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $ModPath/ModSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)
