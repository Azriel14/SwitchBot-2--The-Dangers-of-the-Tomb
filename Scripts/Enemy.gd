extends CharacterBody2D

var time = 0
var speed = 800
var timeThreshold = 1
var detectionRange = 500
var moveDirection = Vector2()

@onready var navigation: NavigationAgent2D = $NavigationAgent
@onready var player = $"../Player"

enum State {idle, moving}
var state = State.idle

func _physics_process(delta):
# Navigation
	var distanceToPlayer = global_position.distance_to(player.position)

	if distanceToPlayer <= detectionRange:
		navigation.target_position = player.position
		var direction = (navigation.get_next_path_position() - global_position).normalized()

# Movement
		if state == State.idle and velocity == Vector2.ZERO:
			time += delta
			if time >= timeThreshold:
				state = State.moving
				if abs(direction.x) > abs(direction.y):
					moveDirection = Vector2(sign(direction.x), 0)
				else:
					moveDirection = Vector2(0, sign(direction.y))
				time = 0
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
