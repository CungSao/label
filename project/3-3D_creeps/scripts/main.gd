extends Node

@export var window_size = Vector2i(720, 540)
@export var mob_scene:PackedScene

@onready var player_position = $Player.position

func _ready():
	$UseInterface/Retry.hide()
	Utils.set_pos_screen(window_size)
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UseInterface/Retry.visible:
		get_tree().reload_current_scene()
		MusicPlayer.play()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = get_node("SpawnPath3D/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	mob_spawn_location.position.y = 1.6
	
	mob.initialize(mob_spawn_location.position, player_position)
	add_child(mob)
	
	mob.squashed.connect($UseInterface/ScoreLabel._on_mob_squashed.bind())

func _on_player_hit():
	$MobTimer.stop()
	MusicPlayer.stop()
	$DeathSound.play()
	
	$UseInterface/Retry.show()
