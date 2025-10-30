extends PathFollow2D

var id:int
var health:float
var player_damage:int
var speed:float
var killReward:int

# Called every frame. 'delta' is the elapsed time since the previous frame.
var enemyStats:enemyBase = preload("res://resources/enemies/test.tres")
func _ready(): 
	id = enemyStats.id
	health = enemyStats.health
	player_damage = enemyStats.playerDamage
	speed = enemyStats.speed
	%EnemySprite.texture = enemyStats.enemySprite
	killReward = enemyStats.killReward
	
func _process(_delta: float) -> void:
	progress_ratio += _delta * speed
	var place = get_progress_ratio()
	if place >= 1:
		GameState.damage(player_damage) #Damages player when it reaches end
		queue_free()
		
	if health <= 0:
		get_parent().get_parent().queue_free()
