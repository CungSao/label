extends RigidBody2D

@export var button_leftRight:NodePath
@export var button_uped:NodePath

@export var visibled:bool
@export var left_right:bool
@export var uped:bool

var velocity:Vector2
var direction = 0

var speed = 400
var angular_speed = PI

func _ready():
	var timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)
	
func _process(delta):
	if left_right:
		if Input.is_action_just_pressed("ui_accept"):
			angular_speed = -angular_speed
		if Input.is_action_pressed("ui_left"):
			direction = -1
		if Input.is_action_pressed("ui_right"):
			direction = 1
		rotation += angular_speed * direction * delta
	else:
		rotation += angular_speed * delta

	if uped && Input.is_action_pressed("ui_up") or !uped:
		velocity = Vector2.UP.rotated(rotation) * speed
		position += velocity * delta

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		print('click')

func _on_button_pressed():
	set_process(!is_processing())

func _on_timer_timeout():
	if visibled:
		visible = !visible
	else:
		visible = true

func _on_button_leftRight_pressed():
	left_right = !left_right
	get_node(button_leftRight).text = "left_right: " + str(left_right)
	
func _on_button_uped_pressed():
	uped = !uped
	get_node(button_uped).text = "uped: " + str(uped)
