extends Node
var isDragging = false;
var isValidPlacement = false;

signal health_changed(current: int, max: int)
signal player_died
signal currency_changed(current:int)

@export var starting_currency:int = 25
@export var max_health := 20

var health := max_health : set = _set_health
var currency:int

func _ready() -> void:
	currency = starting_currency
	emit_signal("health_changed", health, max_health)
	currency_changed.emit(currency)

func _set_health(value: int) -> void:
	health = clamp(value, 0, max_health)
	emit_signal("health_changed", health, max_health)
	if health == 0:
		emit_signal("player_died")

func damage(amount: int = 1) -> void:
	_set_health(health - amount)
	
func reset() -> void:
	_set_health(max_health)
	currency = starting_currency
	currency_changed.emit(currency)

# CURRENCY METHODS
func add_currency(value:int) -> void:
	if value <= 0:
		return
	currency += value
	currency_changed.emit(currency)

func can_afford(cost:int) -> bool:
	return currency >= cost

func spend(cost:int) -> bool:
	if can_afford(cost) == false:
		return false
	currency -= cost
	currency_changed.emit(currency)
	return true
