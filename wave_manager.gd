extends Node

@onready var enemyPath:Path2D = %EnemyPath
var spawn_count: int = 0
# -- Enemy Types --
const ENEMY_GOBLIN := 0
const ENEMY_OGRE := 1
#Packed scenes and packed enemy stats from .tres
#It needs to have an enemy_base.tscn for each unique packed enemy
@export var enemy_scenes: Array[PackedScene] = [
	preload("res://Scenes/enemy_base.tscn"),
	preload("res://Scenes/enemy_base.tscn"),
]
@export var enemy_stats: Array[enemyBase] = [
	preload("res://resources/enemies/Goblin.tres"),
	preload("res://resources/enemies/Ogre.tres"),
]

# -- Wave Config --

# Ecah wave is an array of segments,
# Each segment: { "enemy": type_index, "count": N, "interval": seconds_between_spawns }
var waves := [
	#Wave 1 - 10 goblins, 1s apart
	[
		{"enemy": ENEMY_GOBLIN, "count": 10, "interval": 1.0}
	],
	#Wave 2 - 10 goblins, 1 ogre, 1s apart
	[
		{"enemy": ENEMY_GOBLIN, "count": 5, "interval": 1.0},
		{"enemy": ENEMY_OGRE, "count": 1, "interval": 1.0},
		{"enemy": ENEMY_GOBLIN, "count": 5, "interval": 1.0},
	],
	[
		{"enemy": ENEMY_GOBLIN, "count": 5, "interval": 1.0},
		{"enemy": ENEMY_OGRE, "count": 1, "interval": 1.0},
		{"enemy": ENEMY_GOBLIN, "count": 5, "interval": 1.0},
	]
]

# -- Runtime State --
var current_wave_index: int = -1
var current_segment_index: int = 0
var enemies_spawned_in_segment: int = 0

var active_wave: bool = false
var spawn_timer: float = 0.0

@onready var timer_label: Label = $TimerLabel
@onready var wave_timer: Timer = $Timer

@export var spawn_interval: float = 1.5

func _ready() -> void:
	spawn_timer = 0.0
	timer_label.text = ""
	

func _on_timer_timeout() -> void:
	# Called when the wave timer finishes
	current_wave_index += 1

	# Checks to see if all waves have been sent
	if current_wave_index >= waves.size():
		#In the future we will add a victory screen
		timer_label.text = "All waves done!"
		return

	_start_wave(current_wave_index)


func _start_wave(wave_index: int) -> void:
	active_wave = true
	current_segment_index = 0
	enemies_spawned_in_segment = 0
	spawn_timer = 0.0
	timer_label.text = "Wave %d" % (wave_index + 1)


func _process(delta: float) -> void:
	# Show countdown while waiting for next wave
	if not wave_timer.is_stopped() and not active_wave:
		timer_label.text = "Next wave in: " + str(int(wave_timer.time_left))
	
	# Spawn enemies while a wave is active
	if active_wave:
		_process_spawning(delta)
		
func _process_spawning(delta: float) -> void:
	spawn_timer -= delta
	if spawn_timer > 0.0:
		return

	var wave = waves[current_wave_index]

	# If we ran out of segments in the wave, the wave is done
	if current_segment_index >= wave.size():
		_end_current_wave()
		return

	var segment = wave[current_segment_index]
	var enemy_type: int = segment["enemy"]
	var segment_count: int = segment["count"]
	var interval: float = segment.get("interval", 1.0)

	# Spawn one enemy and assign stats based on enemy_type, index
	var enemy_scene: PackedScene = enemy_scenes[enemy_type]
	var stats: enemyBase = enemy_stats[enemy_type]

	var new_enemy = enemy_scene.instantiate()
	new_enemy.enemyStats = stats
	enemyPath.add_child(new_enemy)

	enemies_spawned_in_segment += 1

	if enemies_spawned_in_segment >= segment_count:
		# Move to the next segment in this wave
		current_segment_index += 1
		enemies_spawned_in_segment = 0

		# If we just finished the last segment, we'll notice next frame and end the wave.

	# Schedule next spawn
	spawn_timer = interval
	
func _end_current_wave() -> void:
	active_wave = false
	spawn_timer = 0.0
	# checks to see if index is smaller than waves array size, if not, victory.
	if current_wave_index + 1 < waves.size():
		wave_timer.start()
	else:
		timer_label.text = "All waves done!"
