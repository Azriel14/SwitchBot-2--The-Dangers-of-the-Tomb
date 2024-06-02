extends CharacterBody2D

var playerTouched = false
var rng = RandomNumberGenerator.new()

@onready var menuPlayer = $"../PlayerMenu"
@onready var menuEnemy = $"../EnemyMenu"
@onready var randomNumberVelocityMinus = rng.randf_range(0, 100)

func _physics_process(_delta):
	if playerTouched:
		menuPlayer.velocity.x = 0
	else:
		velocity.x = Singleton.randomNumberVelocity
		position.y = Singleton.randomNumberY
		if menuEnemy:
			menuEnemy.velocity.x -= randomNumberVelocityMinus
			if menuEnemy.velocity.x <= 200:
				menuEnemy.velocity.x = 400

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		playerTouched = true
		menuPlayer.position.x = RandomNumberGenerator.new().randf_range(-50, -150)
	if body.is_in_group("Enemy"):
		playerTouched = false
		menuEnemy.position.x = RandomNumberGenerator.new().randf_range(-200, -800)
		get_tree().paused = true
		await get_tree().create_timer(RandomNumberGenerator.new().randf_range(1, 5)).timeout
		get_tree().paused = false
		Singleton._change_velocity()
		Singleton._change_y()

