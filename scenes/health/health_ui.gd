extends Control
class_name health_label
@export var health_container:Label

func update_health(new_health: int):
	health_container.text = str(new_health)
