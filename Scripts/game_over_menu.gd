extends Control

@onready var main_panel: Control = $PanelContainer
@onready var title_label: Label = $Label
@onready var restart_button: Button = $PanelContainer/VBoxContainer/Restart
@onready var main_menu_button: Button = $PanelContainer/VBoxContainer/MainMenu

func _ready() -> void:
	
	$AnimationPlayer.play("RESET")
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# listener for when player dies signal is sent
	GameState.player_died.connect(_on_player_died)

	restart_button.pressed.connect(_on_restart_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)

# shows Game over menu
func _on_player_died() -> void:
	get_tree().paused = true
	show()

# restarts the game
func _on_restart_pressed() -> void:
	GameState.reset()
	get_tree().paused = false
	get_tree().reload_current_scene()

# navigates back to main menu - scene change
func _on_main_menu_pressed() -> void:
	GameState.reset()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
