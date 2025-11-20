extends Label

@export var level_index : int
@onready var save_loader: LevelSaverLoader = $"../SaveLoader"

func _ready() -> void:
	visible = false
	await save_loader
	save_loader.save()
	
func  check_visibility():
	var is_level_finished = save_loader.level_status[level_index]
	visible = is_level_finished
