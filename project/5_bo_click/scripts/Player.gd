extends Sprite2D

func check_visible():
	var children = $"../interact".get_children()
	for child in children:
		hide()
		if child.get_node("action").visible: return
		show()
