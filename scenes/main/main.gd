extends Node

@onready var loading_screen: LoadingScreenAnimation = get_node("CanvasLayer/loading_screen_anim")
@onready var title_screen: TitleScreen = get_node("CanvasLayer/title_screen")
@onready var follow_cam: followCam = get_node("followCam")

var player_resource: PackedScene = preload("res://scenes/player/player.tscn")
var player: Player

var current_loaded_level: PackedScene
var current_level: Map

func _process(delta: float) -> void:
	if !current_level:
		var progress = []
		ResourceLoader.load_threaded_get_status("res://resources/maps/debug_maps/debug_map_01.tscn", progress)
		print(progress[0])
		if progress[0] == 1:
			current_loaded_level = ResourceLoader.load_threaded_get("res://resources/maps/debug_maps/debug_map_01.tscn")
			current_level = current_loaded_level.instantiate()
			add_child(current_level)
			title_screen.set_menu(TitleScreen.MENUS.TITLE)
			title_screen.visible = false
			set_the_level()
			loading_screen.pull_out()

func _on_title_screen_start_button() -> void:
	title_screen.set_menu(title_screen.MENUS.LEVEL_SELECT)

func _on_title_screen_level_button(level: int) -> void:
	loading_screen.pop_in()
	ResourceLoader.load_threaded_request("res://resources/maps/debug_maps/debug_map_01.tscn")

func set_the_level():
	player = player_resource.instantiate()
	player.position = current_level.player_spawn_point.position
	follow_cam.thingToFollow = player
	player.z_index = 0
	add_child(player)
