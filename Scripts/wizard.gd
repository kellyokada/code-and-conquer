extends StaticBody2D


var Bullet = preload("res://Scenes/Fireball.tscn")
var bulletDamage = 5
var pathName
var currTargets = []
var curr
var is_active = false
@onready var tower_area_2d: Area2D = $Tower

func _process(_delta):
	if is_active:
		if is_instance_valid(curr):
			self.look_at(curr.global_position)

func _on_tower_body_entered(body: Node2D) -> void:
	if is_active:
		if "Goblin" in body.name:
			var tempArray = []
			currTargets = get_node("Tower").get_overlapping_bodies()
			
			for i in currTargets:
				if "Goblin" in i.name:
					tempArray.append(i)
			var currTarget = null
			
			for i in tempArray:
				if currTarget == null:
					currTarget = i.get_node("../")
				else:
					if i.get_parent().get_progress() > currTarget.get_progress():
						currTarget = i.get_node("../")
			
			curr = currTarget
			pathName = currTarget.get_parent().name
			
			var tempBullet = Bullet.instantiate()
			tempBullet.pathName = pathName
			tempBullet.bulletDamage = bulletDamage
			get_node("BulletContainer").add_child(tempBullet)
			tempBullet.global_position = $Aim.global_position


func _on_tower_body_exited(_body: Node2D) -> void:
	currTargets = get_node("Tower").get_overlapping_bodies()
	
func activate_tower():
	is_active = true
	modulate = Color.WHITE
	
func get_available_areas():
	return tower_area_2d.get_overlapping_areas()
