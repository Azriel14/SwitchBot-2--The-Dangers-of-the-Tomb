extends CharacterBody2D

const maxSpeed := 700
const friction := 5000
const acceleration := 9000

var facing := "downR"
var screenSize: Vector2

func _physics_process(delta):
# Movement
	var inputVector := Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Down") - Input.get_action_strength("Up")
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
	
	if velocity != Vector2(0,0):
		$Particles.emitting = true
	else:
		$Particles.emitting = false

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
		"upR": {"Down": 0, "Left": 3},
		"upL": {"Down": 1, "Right": 2},
		"downR": {"Up": 2, "Left": 1},
		"downL": {"Up": 3, "Right": 0}
	}
	var facingMap = ["downR", "downL", "upR", "upL"]

	var vertical_action = ""
	var horizontal_action = ""

	if Input.is_action_pressed("Up") and not Input.is_action_pressed("Down"):
		vertical_action = "Up"
	elif Input.is_action_pressed("Down") and not Input.is_action_pressed("Up"):
		vertical_action = "Down"

	if Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
		horizontal_action = "Left"
	elif Input.is_action_pressed("Right") and not Input.is_action_pressed("Left"):
		horizontal_action = "Right"

	var action_to_check = [vertical_action, horizontal_action]
	for action in directionMap[facing]:
		if action in action_to_check:
			frame = directionMap[facing][action]
			break

	if frame >= 0:
		facing = facingMap[frame]

	$Dingleton.frame = frame

# What happens when you die because you were killed
func _death():
	var sceneTree = get_tree()
	sceneTree.reload_current_scene()
	print("RIP Dingleton")
