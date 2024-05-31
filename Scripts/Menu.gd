extends Control

var pullOut
var down = 0
var timePassed = 0
var wobbleSpeedX = 4
var wobbleSpeedY = 6
var wobbleAmplitudeX = 0.5
var wobbleAmplitudeY = 0.25

func _physics_process(delta):
# Triangle go down
	down -= 0.15

	$Triangles.region_rect = Rect2(0, down, 16, 272)
	$TrianglesShadow.region_rect = Rect2(0, down, 16, 272)

# Logo wobble
	timePassed += delta

	var xOffset = sin(timePassed * wobbleSpeedX) * wobbleAmplitudeX
	var yOffset = sin(timePassed * wobbleSpeedY) * wobbleAmplitudeY

	$Logo.position.x += xOffset
	$Logo.position.y += yOffset
	$LogoShadow.position.x += xOffset
	$LogoShadow.position.y += yOffset

# Pull out animation

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Stages/1.tscn")

func _on_stage_select_pressed():
	_pull_out()
	pass # Replace with function body.

func _on_options_pressed():
	_pull_out()
	pass # Replace with function body.

func _on_credits_pressed():
	_pull_out()
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()

func _pull_out():
	$MarginContainer
	$Logo
	$LogoShadow
	
