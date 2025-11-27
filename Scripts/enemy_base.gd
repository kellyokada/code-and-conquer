extends PathFollow2D

@export var enemyStats: enemyBase

var id:int
var health:float
var player_damage:int
var speed:float
var killReward:int

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready(): 
	if enemyStats == null:
		enemyStats = preload("res://resources/enemies/Goblin.tres")
	id = enemyStats.id
	health = enemyStats.health
	player_damage = enemyStats.playerDamage
	speed = enemyStats.speed
	killReward = enemyStats.killReward
	
	%EnemySprite.texture = enemyStats.enemySprite
	
func _process(_delta: float) -> void:
	progress_ratio += _delta * speed
	var place = get_progress_ratio()
	if place >= 0.999: #Temp fix for the looping issue
		GameState.damage(player_damage) #Damages player when it reaches end
		queue_free()
		
	

func _damage(damage:float):
	health = health - damage
	if health <= 0.0:
		GameState.add_currency(killReward)
		queue_free()
