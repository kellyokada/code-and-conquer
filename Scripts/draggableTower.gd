extends Area2D

var mouseHovering = false
var isDragging = false
var initialPos:Vector2
var towerNode = preload("res://Scenes/Tower stuff/tower_base_v_2.tscn")

func _process(_delta):
	if (Input.is_action_just_pressed("left_click") && self.mouseHovering == true && isDragging == false):
		isDragging = true
		initialPos = self.global_position
		
		print("clicked")
	if (Input.is_action_just_released("left_click") && isDragging == true):
		
		var newTower = towerNode.instantiate()
		var path = get_tree().get_root()
		#var path = get_tree().get_root().get_node("Main/Towers")
		path.add_child(newTower)
		#TODO will add checking for valid location later. tis time crunch time
		isDragging = false
		self.global_position = initialPos
	if isDragging == true:
		self.global_position = get_global_mouse_position()

func _on_mouse_entered():
	self.mouseHovering = true


func _on_mouse_exited():
	self.mouseHovering = false
