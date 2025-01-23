extends Camera2D

@export var thingToFollow: Node2D
@export var camSpeed: float = 5

var followOffset: Vector2 = Vector2(0, -100)

func _ready():
	if thingToFollow:
		position = thingToFollow.position

func _process(delta: float) -> void:
	if thingToFollow:
		# https://docs.godotengine.org/en/stable/tutorials/math/interpolation.html
		# ^ lerp; very handy function
		position = position.lerp(thingToFollow.position + followOffset, delta * camSpeed)
