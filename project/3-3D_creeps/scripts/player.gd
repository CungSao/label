extends CharacterBody3D

signal hit

@export var speed = 14
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var bounce_impulse = 16

var target_velocity:Vector3

func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
	
	# rotation
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Mesh.basis = Basis.looking_at(direction)

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Gravity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# move
	velocity = target_velocity
	move_and_slide()

	# Err: không thể nhảy chéo xuống
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		target_velocity.y = jump_impulse

	# Iterate through all collisions that occurred this frame
	for index in range(get_slide_collision_count()):
		# We get one of the collisions with the player
		var collision = get_slide_collision(index)

		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			
			# we check that we are hitting it from above.
			if Vector3.UP.dot(collision.get_normal()) > 0.7:
				# If so, we squash it and bounce.
				mob.squash()
				target_velocity.y = bounce_impulse
				
			elif mob:
				die()

func die():
	hit.emit()
	queue_free()
