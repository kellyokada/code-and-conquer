extends TextureRect

@onready var label: Label = $CurrencyLabel

func _ready() -> void:
	# initialize
	label.text = str(GameState.currency)
	# listen for updates
	GameState.currency_changed.connect(_on_currency_changed)

func _on_currency_changed(current:int) -> void:
	label.text = str(current)
