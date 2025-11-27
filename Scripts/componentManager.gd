extends Area2D


@export var myList:VBoxContainer
@export var myListHeader:PanelContainer
@export var myListTitle:Label
@export var myHeaderButton:Button
@export var myScrollContainer:ScrollContainer
@export var listValue:int
@export var defaultHeaderStyle:StyleBoxFlat

@export var testingName:String

@onready var shopTabs:TabContainer = %CompShopTabs
@onready var myWorkspace:HBoxContainer = $"../../../.."

#var defaultHeaderStyle:StyleBoxFlat = "res://Assets/Styles/Default.tres"
var hasComponent = false
var myComponentID = null
var mouseHovering = false

func _process(_delta):
	if (Input.is_action_just_pressed("secret")):
		print(testingName,self.mouseHovering)
		print(self.mouseHovering)
	# && GameState.isDragging == true 
	#if (Input.is_action_just_released("left_click")):
	#	print(GameState.isDragging)
	if (Input.is_action_just_released("left_click") && self.mouseHovering == true && GameState.isDragging == true):
		#True is tower component false is code component
		print("working")
		print(testingName,self.mouseHovering)
		GameState.toggleDragging()
		if (GameState.nodeTypeBeingDragged == false):
			addCompType(GameState.nodeBeingDragged)
			self.hasComponent = true
		elif (GameState.nodeTypeBeingDragged == true):
			addCodeBlock(GameState.nodeBeingDragged)
			pass
	pass

#TODO fix issue where second list doesn't have hasComponent updated
func addCompType(newTab:PackedScene):
	if (self.hasComponent == false):
		myHeaderButton.visible = true
		#TODO I'm hardcoding all of this because time constraints
		#in the future this should change the styling of the header
		#and take in input from the object being added
		#rather than it just being hardcoded
		#but im stressed and don't have time
		#oh btw the reason this doesn't change the style is 
		myListTitle.text = "Activates every second \n when an enemy \n comes in range"
		myListHeader.add_theme_stylebox_override("Ballista",preload("res://Assets/Styles/Ballista.tres"))# = preload("res://Assets/Styles/Ballista.tres")
		print(testingName)
		var temp = newTab.instantiate()
		shopTabs.add_child(temp)
		match listValue:
			1:
				myWorkspace.t1ShopNode = temp
				print(myWorkspace.t1ShopNode)
				print("HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII")
			2:
				myWorkspace.t2ShopNode = temp
			3:
				myWorkspace.t3ShopNode = temp
		self.hasComponent = true
		print("Tab added")
	else:
		print("Tab already has component! Please delete the component before adding a new one")
		pass

func clearCompType():
	if (self.hasComponent == true):
		myListTitle.text = "None"
		myHeaderButton.visible = false
		myListHeader.add_theme_stylebox_override("Default",defaultHeaderStyle)
		self.hasComponent = false
		print("deleted")
		match listValue:
			1:
				print(myWorkspace.t1ShopNode)
				myWorkspace.clearList(self.listValue)
				myWorkspace.t1ShopNode.queue_free()
			2:
				print(myWorkspace.t1ShopNode)
				myWorkspace.clearList(self.listValue)
				myWorkspace.t2ShopNode.queue_free()
			3:
				print(myWorkspace.t1ShopNode)
				myWorkspace.clearList(self.listValue)
				myWorkspace.t3ShopNode.queue_free()
		
		#TODO need a reference to the instantiated node so it can be deleted
	elif (self.hasComponent == false):
		print("How did you hit this button dweeb")
	pass

func addCodeBlock(newBlock:PackedScene):
	if self.hasComponent == true:
		var temp = newBlock.instantiate()
		myList.add_child(temp)
	elif self.hasComponent == false:
		print("Please add a component")
	pass

func swapCodeBlock():
	pass

func deleteCodeBlock():
	pass


func _on_mouse_entered():
	self.mouseHovering = true
	#print("Mouse in on " + testingName)

func _on_mouse_exited():
	self.mouseHovering = false
	#print("Mouse out on " + testingName)
	
func _pressed():
	clearCompType()
	print("Button!")
