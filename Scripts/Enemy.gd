extends CharacterBody2D

var speed = 800
var timeThreshold = 0.2
var moveDirection = Vector2()
var time = 0.0

@onready var allCast = [
	$Cast/ShapeCastUp,
	$Cast/ShapeCastDown,
	$Cast/ShapeCastLeft,
	$Cast/ShapeCastRight
]
@onready var player = $"../Player"
@onready var SFXPlayer = $AudioStreamPlayer
@onready var BoomParticlesTop = $BoomParticles/BoomParticlesTop
@onready var BoomParticlesTop2 = $BoomParticles/BoomParticlesTop2
@onready var BoomParticlesBottom = $BoomParticles/BoomParticlesBottom
@onready var BoomParticlesBottom2 = $BoomParticles/BoomParticlesBottom2
@onready var BoomParticlesLeft = $BoomParticles/BoomParticlesLeft
@onready var BoomParticlesLeft2 = $BoomParticles/BoomParticlesLeft2
@onready var BoomParticlesRight = $BoomParticles/BoomParticlesRight
@onready var BoomParticlesRight2 = $BoomParticles/BoomParticlesRight2

enum State {idle, moving, charging}
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
				SFXPlayer.stream = load("res://Assets/SFX/Charge.ogg")
				SFXDeconflicter.play(SFXPlayer)
				state = State.charging
				break

	elif state == State.charging:
		moveTimer += delta
		if moveTimer >= 1:
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
	
	if !SFXPlayer.playing && velocity != Vector2.ZERO:
		SFXPlayer.stream = load("res://Assets/SFX/Boom.ogg")
		SFXDeconflicter.play(SFXPlayer)
		
	move_and_slide()

# Oh, you touched my tra lalala
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body._death()
	if body.is_in_group("Switch"):
		body._activated()
