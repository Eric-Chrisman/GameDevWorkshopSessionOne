@tool
extends Node2D

@onready var bob_anim: AnimationPlayer = get_node("bob")
@onready var rotate_anim: AnimationPlayer = get_node("rotate")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bob_anim.play("bob")
	rotate_anim.play("rotate")
