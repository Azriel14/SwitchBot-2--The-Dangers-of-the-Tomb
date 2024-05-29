extends CharacterBody2D

var speed = 128
var interval = 1
var timer = 0

func _physics_process(delta):
	timer += delta

	if timer >= interval:
		timer = 0
		move_enemy()

func move_enemy():
	var player_position = $"../Player".get_position()
	var direction = player_position - global_position
	direction = direction.normalized()

	var movement = direction * speed * interval

	movement.x = round(movement.x / 128) * 128
	movement.y = round(movement.y / 128) * 128

	global_position += movement

func _on_area_2d_body_entered(body):
# No no, don't touch me there
	if body.is_in_group("Player"):
		body._death()
