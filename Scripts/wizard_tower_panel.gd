extends Panel

@onready var tower = preload("res://Scenes/wizard.tscn")
var currTile
var actual_tower
var can_place
var can_add_tower

func _on_gui_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.button_mask == 1:
		var temp_tower = tower.instantiate()
		actual_tower = temp_tower
		var path = get_tree().get_root().get_node("Main/Towers")
		path.add_child(actual_tower)
		can_place = true 
		actual_tower.global_position = event.global_position
		
		actual_tower.scale = Vector2(1.3,1.3)

	elif event is InputEventMouseButton and event.button_mask == 0 and actual_tower:
		if can_add_tower :
			actual_tower.activate_tower()
			actual_tower.global_position = event.global_position
			can_place = false
		else: 
			actual_tower.queue_free()
		actual_tower = null 
func _process(delta: float) -> void:
	can_add_tower = can_place and actual_tower and can_add_tower
	if can_place and actual_tower :
		actual_tower.global_position = get_global_mouse_position().snapped(Vector2(32,32))
		var areas= actual_tower.get_available_areas()
		if areas.size() > 0 :
			can_add_tower = false
			actual_tower.modulate = Color.RED
		else:
			can_add_tower = true
			actual_tower.modulate = Color.GREEN
