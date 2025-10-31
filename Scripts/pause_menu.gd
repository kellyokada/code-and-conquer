extends Control

@onready var pause_button = $"../PauseButton"
@onready var leave_confirm = $LeaveConfirm
@onready var main_panel = $PanelContainer

func _ready():
	$AnimationPlayer.play("RESET")
	hide()
	leave_confirm.hide()
	process_mode = Node.PROCESS_MODE_ALWAYS

func resume():
	get_tree().paused = false
	hide()
	$AnimationPlayer.play("blur")
	pause_button.show()
	
func pause():
	get_tree().paused = true
	show()
	$AnimationPlayer.play("blur")
	pause_button.hide()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
	GameState.reset()
	get_tree().reload_current_scene()
	hide()
	
func _on_pause_button_pressed() -> void:
	if get_tree().paused:
		resume()
		hide()
	else:
		pause()
		show()

func _on_leave_pressed() -> void:
	main_panel.hide()
	leave_confirm.show()

func _on_yes_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_no_pressed() -> void:
	leave_confirm.hide()
	main_panel.show()
