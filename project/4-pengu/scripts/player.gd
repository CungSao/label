extends CharacterBody2D

@export var SPEED = 300.0

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction.normalized() * SPEED
		$CanhCut.flip_h = velocity.x < 0
	else:
		velocity = velocity.limit_length(0)
	move_and_slide()
	
func jump():
	$AnimationPlayer.play("jump")
