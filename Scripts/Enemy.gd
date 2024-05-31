extends CharacterBody2D

var time = 0
var speed = 800
var timeThreshold = 1
var detectionRange = 900
var moveDirection = Vector2()

@onready var navigation: NavigationAgent2D = $NavigationAgent
@onready var player = $"../Player"

enum State {idle, moving}
var state = State.idle

func _physics_process(delta):
	# Navigation
	var shape_cast_up_colliding = $ShapeCastUp.is_colliding()
	var shape_cast_down_colliding = $ShapeCastDown.is_colliding()
	var shape_cast_left_colliding = $ShapeCastLeft.is_colliding()
	var shape_cast_right_colliding = $ShapeCastRight.is_colliding()

	# Movement
	if state == State.idle and velocity == Vector2.ZERO:
		time += delta
		if time >= timeThreshold:
			state = State.moving
			time = 0
			
			# Determine move direction based on ShapeCasts when changing to moving state
			if shape_cast_up_colliding:
				moveDirection = Vector2.UP
			elif shape_cast_down_colliding:
				moveDirection = Vector2.DOWN
			elif shape_cast_left_colliding:
				moveDirection = Vector2.LEFT
			elif shape_cast_right_colliding:
				moveDirection = Vector2.RIGHT
				
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
