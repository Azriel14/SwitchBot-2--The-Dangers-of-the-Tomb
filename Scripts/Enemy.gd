extends CharacterBody2D

var speed = 800
var accel = 7

@onready var nav: NavigationAgent2D = $NavigationAgent

enum State {idle, moving}
var state = State.idle

func _physics_process(delta):
	var direction = Vector2()

	nav.target_position = $"../Player".position

	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()

	velocity = velocity. lerp(direction * speed , accel * delta)

	move_and_slide()

func _on_area_2d_body_entered(body):
# No no, don't touch me there
	if body.is_in_group("Player"):
		body._death()
