extends Node

var stage = 1
var rng = RandomNumberGenerator.new()

@onready var randomNumberY = rng.randf_range(385, 700)
@onready var randomNumberVelocity = rng.randf_range(400, 900)

func _physics_process(_delta):
# Speedrun Button
	if Input.get_action_strength("Speedrun"):
		Engine.time_scale = 2
	else:
		Engine.time_scale = 1

func _increment_stage():
	stage += 1

func _change_y():
	randomNumberY = rng.randf_range(385, 700)

func _change_velocity():
	randomNumberVelocity = rng.randf_range(400, 900)
