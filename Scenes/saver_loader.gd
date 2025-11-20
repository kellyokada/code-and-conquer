class_name LevelSaverLoader
extends Node

@export var level_number : int

var data_slot = "res://Data/slot.json"

var is_level_1_finished = false
var is_level_2_finished = false

var level_status = [is_level_1_finished,is_level_2_finished] #Whenever we add more levels we will adapt this script add more boleans to each level status

func _ready() -> void:
		level_status.append(is_level_1_finished)

func save():
	if level_number >= 0 and level_number < level_status.size():
		level_status[level_number]= true
	var data = {
		"l_number":level_status
	}
	var json_data = JSON.stringify(data)
	var json_file = FileAccess.open(data_slot,FileAccess.WRITE)
	json_file.store_line(json_data)
	json_file.close()

func load():
	var json_file = FileAccess.open(data_slot,FileAccess.READ)
	var json_data = json_file.get_as_text()
	json_file.close()
	var data = JSON.parse_string(json_data)
	var conditions = Array(data["l_number"])
	level_status = conditions
	
