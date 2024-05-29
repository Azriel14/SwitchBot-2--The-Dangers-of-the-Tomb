extends CharacterBody2D

const acceleration := 3000 # Speeding up
const maxSpeed := 1000
const friction := 2000 # Slowing down

var screenSize: Vector2
var facing := "downR"

func _physics_process(delta):
# Movement
	var inputVector := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	if inputVector != Vector2():
		inputVector = inputVector.normalized()
		velocity += inputVector * acceleration * delta
		if velocity.length() > maxSpeed:
			velocity = velocity.normalized() * maxSpeed
	else:
		if velocity.length() > 0:
			var frictionForce = friction * delta
			if velocity.length() < frictionForce:
				velocity = Vector2()
			else:
				velocity -= velocity.normalized() * frictionForce

	move_and_slide()
	_update_sprite_frame()

# Teleport to the other side if the player hits the screen's edge
	screenSize = get_viewport().size
	if position.x < 0:
		position.x = screenSize.x
	elif position.x > screenSize.x:
		position.x = 0

	if position.y < 0:
		position.y = screenSize.y
	elif position.y > screenSize.y:
		position.y = 0

# "Animation" - (Azriel writes 'Best code ever'. Asked to commit Third Impact.)
func _update_sprite_frame():
	var frame = $Dingleton.frame
	var directionMap = {
		"upR": {"ui_down": 0, "ui_left": 3},
		"upL": {"ui_down": 1, "ui_right": 2},
		"downR": {"ui_up": 2, "ui_left": 1},
		"downL": {"ui_up": 3, "ui_right": 0}
	}
	var facingMap = ["downR", "downL", "upR", "upL"]

	for action in directionMap[facing]:
		if Input.is_action_pressed(action):
			frame = directionMap[facing][action]
			break

	if frame >= 0:
		facing = facingMap[frame]

	$Dingleton.frame = frame

# What happens when you die because you were killed
func _death():
	var scene_tree = get_tree()
	scene_tree.reload_current_scene()
	print("RIP Dingleton")
