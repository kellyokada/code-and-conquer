extends Node2D

var hovering = false;
var initialPos
@export var componentToPlace:PackedScene;
#TODO global isDragging variable. Potentially apart of some game manager class
#TODO object disconnects when moving too fast, fix is probably simple though

func _process(_delta):
	if hovering:
		if Input.is_action_just_pressed("left_click") && GameState.isDragging == false:
			#get the initial position in case of invalid placement
			initialPos = self.global_position;
			GameState.isDragging = true
		if Input.is_action_pressed("left_click"):
			#while mouse is held set position to mouse position
			self.global_position = get_global_mouse_position()
		if Input.is_action_just_released("left_click"):
			GameState.isDragging = false
			if GameState.isValidPlacement == true:
				var newCompInstance = componentToPlace.instantiate()
				newCompInstance.position = self.position
				get_parent().add_child(newCompInstance)
				print("Test True")
				self.global_position = initialPos
			else: 
				#TODO visual interpolation between invalid placement and original position
				self.global_position = initialPos
				print("Test False")
					
			#TODO Check if placement is valid if valid instantiate a new tower at the position
			#TODO If invalid position create a tween as a part of the tree and move sprite back to original location
			
			return;


func _on_area_2d_mouse_entered():
	#TODO check global is dragging is false
	print("Mouse entered")
	hovering = true;
	scale = Vector2(1.05,1.05)
	
func _on_area_2d_mouse_exited():
	#TODO check global is dragging is false
	print("Mouse exited")
	hovering = false;
	scale = Vector2(1,1)
