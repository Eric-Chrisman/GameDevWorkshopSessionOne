extends Node2D
class_name Health

@export var health_ui_instance_id: health_label

@export var max_health: int = 100
var current_health: int = max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (health_ui_instance_id):
		health_ui_instance_id.update_health(current_health)
