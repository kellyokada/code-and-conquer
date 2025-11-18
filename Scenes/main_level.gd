extends Node2D
@onready var battle_chosic_com_: AudioStreamPlayer = $"Battle(chosic_com)"


func _ready() -> void:
	battle_chosic_com_.play()


func _on_settings_bgs_finished() -> void:
	battle_chosic_com_.play()
