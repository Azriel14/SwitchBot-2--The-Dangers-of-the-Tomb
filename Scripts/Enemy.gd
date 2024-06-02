extends CharacterBody2D

var speed = 800
var timeThreshold = 0.2
var moveDirection = Vector2()
var time = 0.0

@onready var player = $"../Player"
@onready var allCast = [
	$Cast/ShapeCastUp,
	$Cast/ShapeCastDown,
	$Cast/ShapeCastLeft,
	$Cast/ShapeCastRight
]

enum State {idle, moving, waiting}
var state = State.idle
var moveTimer = 0.0

func _physics_process(delta):
# Navigation
	var shapeCastUpColliding = $Cast/ShapeCastUp.is_colliding() &&  $Cast/ShapeCastUp.get_collider(0) == player
	var shapeCastDownColliding = $Cast/ShapeCastDown.is_colliding() && $Cast/ShapeCastDown.get_collider(0) == player
	var shapeCastLeftColliding = $Cast/ShapeCastLeft.is_colliding() && $Cast/ShapeCastLeft.get_collider(0) == player
	var shapeCastRightColliding = $Cast/ShapeCastRight.is_colliding() && $Cast/ShapeCastRight.get_collider(0) == player

# Movement
	if state == State.idle and velocity == Vector2.ZERO:
		moveTimer = 0.0
		for cast in allCast:
			if cast.get_collider(0) == player:
				$AudioStreamPlayer.playing = true
				state = State.waiting
				break
				
	elif state == State.waiting:
		moveTimer += delta
		if moveTimer >= 1.6:
			if shapeCastUpColliding:
				moveDirection = Vector2.UP
			elif shapeCastDownColliding:
				moveDirection = Vector2.DOWN
			elif shapeCastLeftColliding:
				moveDirection = Vector2.LEFT
			elif shapeCastRightColliding:
				moveDirection = Vector2.RIGHT
			state = State.moving
			moveTimer = 0.0

	elif state == State.moving:
		if velocity == Vector2.ZERO:
			time += delta
			if time >= timeThreshold:
				state = State.idle
				time = 0
		else:
			time = 0
		velocity = moveDirection * speed

	move_and_slide()

# Oh, you touched my tra lalala
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body._death()
	if body.is_in_group("Switch"):
		body._activated()
