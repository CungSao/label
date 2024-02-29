extends Node

@export var window_size = Vector2i(480, 720)
@export var mob_scene:PackedScene

var score = 0

func _ready():
	$AnimatedSprite2D.hide()
	set_screen()

func set_screen():
	#window
	DisplayServer.window_set_size(window_size)
	DisplayServer.window_set_position(Vector2i(window_size.x*1.1, window_size.y*0.15))
	#content
	get_tree().root.content_scale_size = window_size
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS

func game_over():
	$Music.stop()
	$DeathSound.play()

	$ScoreTimer.stop()
	$HUD.show_game_over()

func new_game():
	$Music.play()
	get_tree().call_group("mobs", "queue_free")
	$Player.get_node("AnimatedSprite2D").flip_v = false
	
	score = 0
	$Player.start($StartPos.position)
	$StartTimer.start()

	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_score_timer_timeout():
	score += 1
	
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout():
	# Choose a random location on Path2D.
	var mob_spawn_location = $ModPath/ModSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# hiện cảnh báo
	$AnimatedSprite2D.position = mob_spawn_location.position
	$AnimatedSprite2D.show()
	$MobTimer.stop()
	await get_tree().create_timer(0.5).timeout
	$AnimatedSprite2D.hide()
	
	# kiểm soát timer
	if !$ScoreTimer.is_stopped():
		$MobTimer.start()
	
	var mob = mob_scene.instantiate()
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2
	#print(direction)

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)
