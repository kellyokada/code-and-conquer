extends MarginContainer

var hovering = false
var initialPos
var myOffset = Vector2(127,37.5)
var dragging = false
#REMEMBER TO SET Z INDEX IN CANVASITEM->ORDERING TO 1 OR HIGHER
@export_category("Settings")
@export var codeToLoad:PackedScene
#True is tower component false is code component
@export var cType:bool




func _on_area_2d_mouse_entered():
	#print("entered")
	hovering = true

func _on_area_2d_mouse_exited():
	#print("exited")
	hovering = false

func _process(_delta):
	if (self.hovering == true):
		self.scale = Vector2(1.05,1.05)
	if (self.hovering == false):
		self.scale = Vector2(1.,1.)
	if (Input.is_action_just_pressed("left_click") && self.hovering == true && GameState.isDragging == false):
		initialPos = self.global_position
		self.dragging = true
		GameState.toggleDragging()
		print("a simple test")
		GameState.nodeBeingDragged = codeToLoad
		GameState.nodeTypeBeingDragged = cType
	if (Input.is_action_just_released("left_click")  && self.hovering == true && self.dragging == true):
		self.dragging = false
		#GameState.toggleDragging()
		var tween = get_tree().create_tween()
		tween.tween_property(self,"global_position", initialPos,0.2)
		tween.set_ease(Tween.EASE_OUT)
	if (self.dragging == true):
		self.global_position = get_global_mouse_position() - myOffset
	
