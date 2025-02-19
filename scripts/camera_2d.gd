extends Camera2D
class_name followCam

@export var thingToFollow: Node2D
@export var camSpeed: float = 5

var idle_speed_x: float = 50
var idle_speed_y: float = 0
var sin_wave_progress_speed: float = 0.3
var sin_wave_progress: float = 0
var sin_wave_magitude: float = 1

var followOffset: Vector2 = Vector2(0, -100)

func _ready():
	if thingToFollow:
		position = thingToFollow.position

func _process(delta: float) -> void:
	if thingToFollow:
		# https://docs.godotengine.org/en/stable/tutorials/math/interpolation.html
		# ^ lerp; very handy function
		position = position.lerp(thingToFollow.position + followOffset, delta * camSpeed)
	
	else:
		position += (Vector2(idle_speed_x, idle_speed_y) * delta) + Vector2(0, sin(sin_wave_progress) * sin_wave_magitude)
		sin_wave_progress += sin_wave_progress_speed * delta
