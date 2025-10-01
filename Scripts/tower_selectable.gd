extends Node2D


var draggable = false;
#TODO global isDragging variable. Potentially apart of some game manager class
#TODO object disconnects when moving too fast, fix is probably simple though

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("left_click"):
			#get the initial position in case of invalid placement
			var initialPos = self.global_position;
			#TODO set isDragging to true
		if Input.is_action_pressed("left_click"):
			#while mouse is held set position to mouse position
			self.global_position = get_global_mouse_position()
		if Input.is_action_just_released("left_click"):
			#TODO set isdragging to false
			#TODO Check if placement is valid if valid instantiate a new tower at the position
			#TODO If invalid position create a tween as a part of the tree and move sprite back to original location
			
			return;


func _on_area_2d_mouse_entered():
	#TODO check global is dragging is false
	print("Mouse entered")
	draggable = true;
	scale = Vector2(1.05,1.05)
	
func _on_area_2d_mouse_exited():
	#TODO check global is dragging is false
	print("Mouse exited")
	draggable = false;
	scale = Vector2(1,1)
