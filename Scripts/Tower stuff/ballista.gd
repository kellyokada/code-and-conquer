extends StaticBody2D

@onready var arrow:PackedScene = preload("res://Scenes/Tower stuff/ballista_arrow.tscn")
var enemyArray:Array[PathFollow2D]
var currentTarget
var loadedArrows:int = 0
var currentTargets = []
var spawnLocation:Vector2

var funcOrder:Array[int]
var currentFunc:int = 0


func _ready():
	print("hello i exist")

#TODO fix this, this is wrong and only executes ballista funcs when it should
#be able to execute anything. not my problem rn
func execute(select:int):
	print(currentFunc)
	match select:
		1:
			loadArrow()
		2:
			fireArrow()
		3:
			getTarget()
		_:
			print("Invalid function")

func _on_rof_timer_timeout():
	if enemyArray.is_empty() == false:
		print("DO THE TING")
	if currentFunc >= funcOrder.size():
		currentFunc = 0
	execute(funcOrder[currentFunc])
	currentFunc = currentFunc + 1
	

func getTarget():
	if is_instance_valid(currentTarget):
		print("Target still valid")
	else:
		var tempArray = []
		currentTargets = get_node("Area2D").get_overlapping_bodies()
		for i in currentTargets:
			if "Enemy" in i.name:
				tempArray.append(i)
		var currTarget = null
			
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
		currentTarget = currTarget

func loadArrow():
	loadedArrows = loadedArrows + 1

func fireArrow():
	if is_instance_valid(currentTarget):
		var tempBullet = arrow.instantiate()
		tempBullet.position = spawnLocation
		tempBullet.target = currentTarget
		%BulletContainer.add_child(tempBullet)
	else:
		#TODO should have a little notification display saying no arrows
		print("No target!")
		pass


func _on_area_2d_body_entered(body) -> void:
	#not being used
	print("body entered")
	if "Enemy" in body.name:
		pass
	else:
		print("not an enemy")


func _on_area_2d_body_exited(body) -> void:
	print("something")
	if body.get_parent() == currentTarget:
		print("target left")
		currentTarget = null
