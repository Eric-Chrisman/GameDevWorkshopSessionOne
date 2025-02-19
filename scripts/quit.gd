extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		quit()

func _on_center_container_quit_button() -> void:
	quit()

func quit():
	get_tree().quit()
