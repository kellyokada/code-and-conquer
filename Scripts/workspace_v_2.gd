extends HBoxContainer

var t1ShopNode:VBoxContainer
var t2ShopNode:VBoxContainer
var t3ShopNode:VBoxContainer

@onready var t1 = $"Tower components/HBoxContainer/Tower1/T1List"
@onready var t2 = $"Tower components/HBoxContainer/Tower2/T2List"
@onready var t3 = $"Tower components/HBoxContainer/Tower3/T3List"
@export var myTower:Area2D

func moveComponent():
	
	pass
	

func clearList(listToClear):
	print("Write the function dumbass", listToClear)




func _on_finish_button_pressed():
	self.visible = false
	if t1ShopNode !=null:
		var tempArray:Array[int]
		for child: PanelContainer in t1.get_children():
			if "funcID" in child:
				tempArray.append(child.funcID)
		print(t1ShopNode.nodeToLoad)
		print("meeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee")
		var temp = t1ShopNode.nodeToLoad.instantiate()
		print(temp)
		temp.funcOrder = tempArray
		temp.spawnLocation = myTower.spawnLocation
		print("My spawn location: ", myTower.spawnLocation)
		print(temp.funcOrder)
		myTower.add_child(temp)
		
	if t2ShopNode !=null:
		var tempArray:Array[int]
		for child: PanelContainer in t2.get_children():
			if "funcID" in child:
				tempArray.append(child.funcID)
		var temp = t1ShopNode.nodeToLoad
		temp.funcOrder = tempArray
		temp.spawnLocation = myTower.spawnLocation
		print("My spawn location: ", myTower.spawnLocation)
		myTower.add_child(temp)
		
	if t3ShopNode !=null:
		var tempArray:Array[int]
		for child: PanelContainer in t3.get_children():
			if "funcID" in child:
				tempArray.append(child.funcID)
		var temp = t1ShopNode.nodeToLoad
		temp.funcOrder = tempArray
		temp.spawnLocation = myTower.spawnLocation
		print("My spawn location: ", myTower.spawnLocation)
		myTower.add_child(temp)
		
