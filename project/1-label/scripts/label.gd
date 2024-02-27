extends Label

@export var ten = "test"
var num = 1

func _ready():
	set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	#$LineEdit.text = ten

func add_one():
	num += 1
	
func _process(_delta):
	if num > 1:
		text = num
	#text = $LineEdit.text
