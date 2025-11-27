extends Label

func _process(_delta):
	var myV2 = get_global_mouse_position()
	var format_string = "MPos is: %s"
	var actual_string = format_string % myV2
	self.text = actual_string
	#var newText = ("Mouse position is: " + get_global_mouse_position().x)
	#self.text = get_global_mouse_position()
