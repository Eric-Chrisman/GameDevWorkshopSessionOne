extends TileMapLayer
class_name Map

@onready var main: Main = get_parent()
var player_spawn_point: Vector2 = Vector2(0, 0)

func _ready() -> void:
	var childern: Array[Node] = get_children()
	for child in childern:
		if child is Spwan_Point:
			player_spawn_point = child.position
		if child is Star:
			child.connect("star_collected", main.deload_level)
