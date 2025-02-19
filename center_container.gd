extends CenterContainer
class_name LoadingScreenAnimation

@onready var bloom_anim: AnimationPlayer = get_node("bloom")
@onready var rotate_anim: AnimationPlayer = get_node("rotate_arrow")

signal popped_in

func _ready():
	visible = false
	rotate_anim.play("rotate_arrow")

func pop_in():
	bloom_anim.play("loading")
	visible = true

func pull_out():
	bloom_anim.play("unloading")

func _on_bloom_animation_finished(anim_name: StringName) -> void:
	if anim_name == "unloading":
		visible = false
	elif anim_name == "loading":
		emit_signal("popped_in")
