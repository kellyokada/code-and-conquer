extends Panel

@onready var tower = preload("res://Scenes/wizard.tscn")
var currTile

func _on_gui_input(event: InputEvent) -> void:
	var tempTower = tower.instantiate()
	
	if event is InputEventMouseButton and event.button_mask == 1:
		add_child(tempTower)
		tempTower.global_position = event.global_position
		tempTower.process_mode = Node.PROCESS_MODE_DISABLED
		
		tempTower.scale = Vector2(1.3,1.3)
		
	elif event is InputEventMouseMotion and event.button_mask == 1:
		if get_child_count() > 1:
			get_child(1).global_position = event.global_position
		
			var mapPath = get_tree().get_root().get_node("Main/TileMap")
			var tile = mapPath.local_to_map(get_global_mouse_position())
			currTile = mapPath.get_cell_atlas_coords(0, tile, false)
			
			if (currTile == Vector2i(0,0)):
				get_child(1).get_node("Area").modulate = Color(0,255,0)
			#else:
				#get_child(1).get_node("Area").modulate = Color(255,0,255)
			
	elif event is InputEventMouseButton and event.button_mask == 0:
		if get_child_count() > 1:
			get_child(1).queue_free()
		var path = get_tree().get_root().get_node("Main/Towers")
		
		path.add_child(tempTower)
		tempTower.global_position = event.global_position
		tempTower.get_node("Area").hide()
