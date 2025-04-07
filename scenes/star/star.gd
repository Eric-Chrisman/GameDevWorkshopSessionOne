@tool
extends Node2D
class_name Star

@onready var bob_anim: AnimationPlayer = get_node("bob")
@onready var rotate_anim: AnimationPlayer = get_node("rotate")

signal star_collected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bob_anim.play("bob")
	rotate_anim.play("rotate")

func _on_area_2d_area_entered(area: Area2D) -> void:
	emit_signal("star_collected")
