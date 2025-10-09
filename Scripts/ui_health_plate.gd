extends TextureRect

@onready var value_label: Label = $ValueLabel
var _prev := 0

func _ready() -> void:
	_prev = GameState.health
	_update_text(GameState.health)
	
	GameState.health_changed.connect(_on_health_changed)

func _on_health_changed(current: int, _maxv: int) -> void:
	_update_text(current)
	if current < _prev:
		var t := create_tween()
		t.tween_property(value_label, "scale", Vector2(1.15, 1.15), 0.06)
		t.tween_property(value_label, "scale", Vector2.ONE, 0.08)
	_prev = current

func _update_text(current: int) -> void:
	value_label.text = str(current)
