extends CharacterBody2D

var time = 0
var speed = 800
var timeThreshold = 1
var detectionRange = 900
var moveDirection = Vector2()

@onready var player = $"../Player"
@onready var allCast = [
	$Cast/ShapeCastUp,
	$Cast/ShapeCastDown,
	$Cast/ShapeCastLeft,
	$Cast/ShapeCastRight
	]

enum State {idle, moving}
var state = State.idle

func _physics_process(delta):
	# Navigation
	var shapeCastUpColliding = $Cast/ShapeCastUp.is_colliding() &&  $Cast/ShapeCastUp.get_collider(0) == player
	var shapeCastDownColliding = $Cast/ShapeCastDown.is_colliding() && $Cast/ShapeCastDown.get_collider(0) == player
	var shapeCastLeftColliding = $Cast/ShapeCastLeft.is_colliding() && $Cast/ShapeCastLeft.get_collider(0) == player
	var shapeCastRightColliding = $Cast/ShapeCastRight.is_colliding() && $Cast/ShapeCastRight.get_collider(0) == player

	# Movement
	if state == State.idle and velocity == Vector2.ZERO:
		time += delta
		if time >= timeThreshold:
			state = State.moving
			time = 0

		for cast in allCast:
			if cast.get_collider(0) == player:
				if shapeCastUpColliding:
					moveDirection = Vector2.UP
				elif shapeCastDownColliding:
					moveDirection = Vector2.DOWN
				elif shapeCastLeftColliding:
					moveDirection = Vector2.LEFT
				elif shapeCastRightColliding:
					moveDirection = Vector2.RIGHT
				break
				
	elif state == State.moving:
		if velocity == Vector2.ZERO:
			time += delta
			if time >= timeThreshold:
				state = State.idle
				time = 0
		else:
			time = 0
		velocity = moveDirection * speed
	else:
		if state == State.moving:
			if velocity == Vector2.ZERO:
				time += delta
				if time >= timeThreshold:
					state = State.idle
					time = 0
			else:
				time = 0
			velocity = moveDirection * speed
		else:
			velocity = Vector2.ZERO
			time = 0

	move_and_slide()

# Oh, you touched my tra lalala
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body._death()
	if body.is_in_group("Switch"):
		body._activated()
