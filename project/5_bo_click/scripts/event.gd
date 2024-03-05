extends Sprite2D

var is_act:bool 

func _input(event):
	if event is InputEventMouseMotion:
		$Indicator.hide()
		if $action.visible: return
		if get_rect().has_point(to_local(event.position)):
			$Indicator.show()

	if event is InputEventMouseButton and event.is_pressed():
		if get_rect().has_point(to_local(event.position)):
			handleClickSecond()
			$action.show()
		else:
			$action.hide()
			is_act = false
			
		get_node("/root/Main/Player").check_visible()
		
func handleClickSecond():
	if is_act and name == "Ho":
		var rand = randi_range(1,4)
		get_node("/root/Main").add(rand)
		$"../Ho/Label".show()
		$"../Ho/Label".text = "+" + str(rand)
		$"../Ho/AnimationPlayer".play("score")
	else:
		is_act = true
