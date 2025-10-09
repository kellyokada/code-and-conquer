extends Node

var isDragging = false;
var isValidPlacement = false;

signal health_changed(current: int, max: int)
signal player_died

@export var max_health := 20
var health := max_health : set = _set_health

func _ready() -> void:
	emit_signal("health_changed", health, max_health)

func _set_health(value: int) -> void:
	health = clamp(value, 0, max_health)
	emit_signal("health_changed", health, max_health)
	if health == 0:
		emit_signal("player_died")

func damage(amount: int = 1) -> void:
	_set_health(health - amount)

func reset() -> void:
	_set_health(max_health)
