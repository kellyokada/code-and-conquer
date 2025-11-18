extends Control
@onready var settings_bgs: AudioStreamPlayer = $SettingsBgs


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings_bgs.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
