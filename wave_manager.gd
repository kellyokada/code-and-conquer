extends Node

@onready var enemyPath:Path2D = %EnemyPath
var enemyBase:PackedScene = preload("res://Scenes/enemy_base.tscn")



func _on_timer_timeout():
	var newEnemy = enemyBase.instantiate()
	enemyPath.add_child(newEnemy)
	pass # Replace with function body.
