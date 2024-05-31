extends Node

var stage = 1
var rng = RandomNumberGenerator.new()

@onready var randomNumberY = rng.randf_range(345, 740)
@onready var randomNumberVelocity = rng.randf_range(400, 900)

func _increment_stage():
	stage += 1

func _change_y():
	randomNumberY = rng.randf_range(345, 740)

func _change_velocity():
	randomNumberVelocity = rng.randf_range(400, 900)
