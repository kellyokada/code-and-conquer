extends Area2D

@onready var workspace:HBoxContainer = $"../Workspace"
@onready var toggler:Button = $WorkspaceToggler

var spawnLocation:Vector2

func _ready():
	
	self.global_position = get_global_mouse_position()
	spawnLocation = get_global_mouse_position()
	


func _on_button_pressed():
	toggler.visible = !toggler.visible


func _on_workspace_toggeler_pressed():
	workspace.visible = true
