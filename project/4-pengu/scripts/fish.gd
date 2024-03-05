extends RigidBody2D

@export var is_control = false
@export var speed = 400

func _ready():
	add_to_group("fish")

func _process(delta):
	if is_control:
		var velocity = Vector2.ZERO
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		elif Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		elif Input.is_action_pressed("ui_up"):
			velocity.y -= 1

		if velocity.length() > 0:
			$Sprite2D.flip_h = velocity.x < 0
			velocity = velocity.normalized() * speed
		
		position += velocity * delta

func _on_timer_timeout():
	queue_free()
