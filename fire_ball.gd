extends CharacterBody2D

var speed = 1000
var pathName = ""
var bulletDamage

var target

@onready var fireball_sfx: AudioStreamPlayer = $FireballSfx

func _ready() -> void:
	fireball_sfx.play()

func _physics_process(_delta: float) -> void:
	
	if target: 
		velocity = global_position.direction_to(target.global_position) * speed
		
		look_at(target.global_position)
		
		move_and_slide()
	else:
		return


func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Enemy" in body.name:
		var parent = body.get_parent()
		parent.health -= bulletDamage
		queue_free()
