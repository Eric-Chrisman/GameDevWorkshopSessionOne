extends CharacterBody2D

# Important: Inputs "space", "left", "right" are definded in Project > Project Settings > Input Map

@export var sprite: AnimatedSprite2D

var jumpPower:float = -1500
var moveSpeed:float = 200000
var gravity:float = 3000

func _process(delta: float) -> void:
	# gravity and jump check; remenber, down is positive y direction; up is negitive y direction
	var moveVector:Vector2 = Vector2(0, velocity.y)
	if is_on_floor():
		if Input.is_action_just_pressed("space"):
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
	
	velocity = moveVector
	move_and_slide()
