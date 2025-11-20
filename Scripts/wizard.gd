extends StaticBody2D


var Bullet = preload("res://Scenes/Fireball.tscn")
var bulletDamage = 5
var pathName
var currTargets = []
var curr
var is_active = false
@onready var tower_detection: Area2D = $TowerDetection
@onready var tower_placement_area: Area2D = $TowerPlacementArea


func _process(_delta):
	if is_active : 
		if is_instance_valid(curr):
			self.look_at(curr.global_position)

func _on_tower_body_entered(body: Node2D) -> void:
	if is_active:
		if "Enemy" in body.name:
			var tempArray = []
			currTargets = get_node("Tower").get_overlapping_bodies()
			
			for i in currTargets:
				if "Enemy" in i.name:
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
			tempBullet.target = currTarget
			get_node("BulletContainer").add_child(tempBullet)
			tempBullet.global_position = $Aim.global_position


func _on_tower_body_exited(_body: Node2D) -> void:
	currTargets = get_node("Tower").get_overlapping_bodies()

func activate_tower():
	is_active = true
	deactivate_area()
	modulate = Color.WHITE
	
func tower_overlap():
	var tower_areas = tower_detection.get_overlapping_areas()
	var player_areas = tower_placement_area.get_overlapping_areas()
	
	if player_areas.size() >0 :
		if tower_areas.size() > 0 :
			return false
		else :
			return true
	else :
		return false
		
func deactivate_area():
	tower_detection.monitoring = false
	tower_placement_area.monitorable = false
	tower_placement_area.monitoring = false
	
