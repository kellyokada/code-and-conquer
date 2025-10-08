extends Control
@onready var pause_button = $"../PauseButton"

func _ready():
	$AnimationPlayer.play("RESET")
	hide()
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
	get_tree().reload_current_scene()
	hide()

func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_pause_button_pressed() -> void:
	if get_tree().paused:
		resume()
		hide()
	else:
		pause()
		show()
