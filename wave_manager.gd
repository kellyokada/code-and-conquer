extends Node

@onready var enemyPath:Path2D = %EnemyPath
var enemyBase:PackedScene = preload("res://Scenes/enemy_base.tscn")
var spawn_count: int = 0
var max_enemies: int = 25

@export var spawn_interval: float = 1.5
var spawn_timer: float = 0.0

@onready var timer_label = $TimerLabel

func _process(delta):
	if $Timer.is_stopped() == false:
		timer_label.text = "Time Left: " + str(int($Timer.time_left))
		
	if $Timer.is_stopped() and spawn_count < max_enemies:
		spawn_timer -= delta
		if spawn_timer <= 0:
			var newEnemy = enemyBase.instantiate()
			enemyPath.add_child(newEnemy)
			spawn_count += 1
			spawn_timer = spawn_interval
