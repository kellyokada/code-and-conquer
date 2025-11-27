extends PanelContainer

@export_category("ID's")
@export var funcID:int





func _on_remove_pressed():
	print("why")
	self.queue_free()
