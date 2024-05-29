extends CharacterBody2D

var speed = 800
var detectionRange = 500
var threshold_velocity = 100
var time_below_threshold = 0
var time_threshold = 1
var move_direction = Vector2()

@onready var navigation: NavigationAgent2D = $NavigationAgent
@onready var player = $"../Player"

enum State {idle, moving}
var state = State.idle

func _physics_process(delta):
# Navigation
	var direction = Vector2()
	var distance_to_player = global_position.distance_to(player.position)

	if distance_to_player <= detectionRange:
		navigation.target_position = player.position
		direction = navigation.get_next_path_position() - global_position
		direction = direction.normalized()

# Movement
		if abs(direction.x) > abs(direction.y):
			move_direction = Vector2(direction.x, 0)
		else:
			move_direction = Vector2(0, direction.y)

		if state == State.idle:
			time_below_threshold += delta
			if time_below_threshold >= time_threshold:
				state = State.moving
				time_below_threshold = 0

		if state == State.moving:
			if velocity.length() < threshold_velocity:
				velocity = move_direction * speed
		else:
			velocity = Vector2.ZERO

	else:
		if state == State.moving:
			if velocity.length() < threshold_velocity:
				velocity = move_direction * speed
		else:
			velocity = Vector2.ZERO
			state = State.idle
			time_below_threshold = 0

	move_and_slide()

# No no, don't touch me there
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body._death()
