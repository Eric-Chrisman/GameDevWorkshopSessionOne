extends Node
class_name Main

@onready var loading_screen: LoadingScreenAnimation = get_node("CanvasLayer/loading_screen_anim")
@onready var title_screen: TitleScreen = get_node("CanvasLayer/title_screen")
@onready var follow_cam: followCam = get_node("followCam")

var player_resource: PackedScene = preload("res://scenes/player/player.tscn")
var player: Player

var current_loaded_level: PackedScene
var current_level: Map

var current_map: String
var directory: String = "res://resources/maps/debug_maps"
var levels: Array[String] = []

func _ready() -> void:
	var current_dir: DirAccess = DirAccess.open(directory)
	if current_dir:
		var files = current_dir.get_files()
		for file in files:
			levels.append(file)
	levels.sort()
	print(levels)

func _process(delta: float) -> void:
	if !current_level and current_map:
		var progress = []
		ResourceLoader.load_threaded_get_status(current_map, progress)
		# print(progress[0])
		if progress[0] == 1:
			current_loaded_level = ResourceLoader.load_threaded_get(current_map)
			current_level = current_loaded_level.instantiate()
			add_child(current_level)
			title_screen.set_menu(TitleScreen.MENUS.TITLE)
			title_screen.visible = false
			set_the_level()
			loading_screen.pull_out()

func _on_title_screen_start_button() -> void:
	title_screen.set_menu(title_screen.MENUS.LEVEL_SELECT)

func _on_title_screen_level_button(level: int) -> void:
	level -= 1
	if (level >= 0 and level < levels.size()):
		loading_screen.pop_in()
		current_map = directory + "/" + levels[level]
		ResourceLoader.load_threaded_request(current_map)

func set_the_level():
	player = player_resource.instantiate()
	player.position = current_level.player_spawn_point
	follow_cam.thingToFollow = player
	player.z_index = 0
	add_child(player)

func deload_level():
	loading_screen.pop_in()
	current_level.call_deferred("free")
	follow_cam.thingToFollow = null
	player.free()
	current_level = null
	title_screen.visible = true
	loading_screen.pull_out()
	
