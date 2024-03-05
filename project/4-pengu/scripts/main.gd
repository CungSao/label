extends Node

@export var fish_scene:PackedScene

func _on_fish_timer_timeout():
	# Choose a random location on Path2D.
	var fish_spawn_location = $fishPath/fishSpawnLocation
	fish_spawn_location.progress_ratio = randf()
	var fish = fish_scene.instantiate()
	
	fish.position = fish_spawn_location.position
	var direction = fish_spawn_location.rotation + PI / 2
	direction = randf_range(-PI / 4, PI / 4)
	fish.rotation = direction

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	fish.linear_velocity = velocity.rotated(direction)

	add_child(fish)
