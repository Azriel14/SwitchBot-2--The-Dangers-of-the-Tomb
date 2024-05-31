extends CharacterBody2D

var playerTouched = false
var rng = RandomNumberGenerator.new()

@onready var randomNumberVelocityMinus = rng.randf_range(0, 100)

func _physics_process(_delta):
	if playerTouched:
		$"../PlayerMenu".velocity.x = 0
	else:
		velocity.x = Singleton.randomNumberVelocity
		position.y = Singleton.randomNumberY
		if $"../EnemyMenu":
			$"../EnemyMenu".velocity.x -= randomNumberVelocityMinus
			if $"../EnemyMenu".velocity.x <= 200:
				$"../EnemyMenu".velocity.x = 400

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		playerTouched = true
		$"../PlayerMenu".position.x = RandomNumberGenerator.new().randf_range(-50, -150)
	if body.is_in_group("Enemy"):
		playerTouched = false
		$"../EnemyMenu".position.x = RandomNumberGenerator.new().randf_range(-200, -800)
		get_tree().paused = true
		await get_tree().create_timer(RandomNumberGenerator.new().randf_range(1, 5)).timeout
		get_tree().paused = false
		Singleton._change_velocity()
		Singleton._change_y()

