extends CharacterBody2D

var rng = RandomNumberGenerator.new()

func _physics_process(delta):
	var randomNumber = rng.randf_range(128, 960)
	velocity.x = randomNumber
	position.y = randomNumber

	move_and_slide()
