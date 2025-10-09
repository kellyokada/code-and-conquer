extends Node2D

var workspaceActive = false


func _ready():
	self.position = Vector2(0,-1230)
func _on_valid_space_mouse_entered():
	GameState.isValidPlacement = true


func _on_valid_space_mouse_exited():
	GameState.isValidPlacement = false


func _on_button_pressed():
	if workspaceActive == true:
		self.position = Vector2(0,-1230)
		workspaceActive = false
	elif workspaceActive == false:
		self.position = Vector2(0,0)
		workspaceActive = true
