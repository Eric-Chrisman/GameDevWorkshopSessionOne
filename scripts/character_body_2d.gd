extends CharacterBody2D
class_name Player

# Important: Inputs "space", "left", "right" are definded in Project > Project Settings > Input Map

@export var sprite: AnimatedSprite2D
@export var player_hurt_box: Area2D

var jumpPower:float = -1500
var moveSpeed:float = 50000 * 2
var gravity:float = 3000

var is_slowed_down:bool = false
var slowed_down_percent = 0.5

func _process(delta: float) -> void:
	check_slow()
	# gravity and jump check; remenber, down is positive y direction; up is negitive y direction
	var moveVector:Vector2 = Vector2(0, velocity.y)
	if is_on_floor():
		if Input.is_action_just_pressed("space"):
			if is_slowed_down:
				moveVector.y = jumpPower * slowed_down_percent
			else:
				moveVector.y = jumpPower
		else:
			moveVector.y = 0
	else:
		moveVector.y += gravity * delta
	
	# move left right check
	if Input.is_action_pressed("left"):
		moveVector.x -= 1
	if Input.is_action_pressed("right"):
		moveVector.x += 1
	moveVector.x = moveVector.x * delta * moveSpeed
	
	if (sprite):
		if !(is_on_floor()):
			sprite.animation = "air"
			sprite.stop()
		elif abs(moveVector.x) < 0.00001:
			sprite.animation = "idle"
			sprite.stop()
		else:
			sprite.animation = "run"
			sprite.play()
		
		if moveVector.x > 0:
			sprite.flip_h = false
		elif moveVector.x < 0:
			sprite.flip_h = true
	
	if is_slowed_down:
		if is_on_floor():
			moveVector.x *= slowed_down_percent
		else:
			moveVector.x *= (slowed_down_percent * 1.5)
		
	velocity = moveVector
	move_and_slide()

func check_slow():
	if !player_hurt_box:
		return
	
	var areas = player_hurt_box.get_overlapping_areas()
	for area in areas:
		if area is snow_block:
			is_slowed_down = true
			return
	is_slowed_down = false
