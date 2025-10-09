extends CharacterBody2D

var health = 10
@export var player_damage := 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var place = get_parent().get_progress_ratio()
	if place >= 1:
		GameState.damage(player_damage) #Damages player when it reaches end
		queue_free()
		
	if health <= 0:
		get_parent().get_parent().queue_free()
