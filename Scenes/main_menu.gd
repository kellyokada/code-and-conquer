extends Control
@onready var settings_bgs: AudioStreamPlayer = $SettingsBgs


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings_bgs.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$VBoxContainer/StartButton.set_process(false)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options.tscn")


func _on_settings_bgs_finished() -> void:
	settings_bgs.play()
