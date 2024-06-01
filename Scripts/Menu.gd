extends Control

var pullIn
var pullOut
var skibidi
var rizz = 0
var gyat = 0
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
	$InTriangles.region_rect = Rect2(0, down + 8, 16, 272)
	$InTrianglesShadow.region_rect = Rect2(0, down + 8, 16, 272)

# Logo wobble
	timePassed += delta

	var xOffset = sin(timePassed * wobbleSpeedX) * wobbleAmplitudeX
	var yOffset = sin(timePassed * wobbleSpeedY) * wobbleAmplitudeY

	$Logo.position.x += xOffset
	$Logo.position.y += yOffset
	$LogoShadow.position.x += xOffset
	$LogoShadow.position.y += yOffset

# Feckin' sick menu animation
	if pullOut:
		if $ColorRect.size.x <= 1015 && skibidi:
			$Logo.position.x -= gyat
			$LogoShadow.position.x -= gyat
			$Buttons.position.x -= gyat
			$ColorRect.size.x += gyat
			$ColorRectShadow.size.x += gyat
			$Triangles.position.x += gyat
			$TrianglesShadow.position.x += gyat
			gyat += 1
		elif !skibidi:
			$ColorRect.size.x -= rizz
			$ColorRectShadow.size.x -= rizz
			$Triangles.position.x -= rizz
			$TrianglesShadow.position.x -= rizz
			rizz += 1
			if rizz == 8:
				skibidi = true

	if Input.get_action_strength("Back"):
		_pull_in()

	if pullIn:
		if $ColorRect.size.x > 448 && !skibidi:
			$Logo.position.x += gyat
			$LogoShadow.position.x += gyat
			$Buttons.position.x += gyat
			$ColorRect.size.x -= gyat
			$ColorRectShadow.size.x -= gyat
			$Triangles.position.x -= gyat
			$TrianglesShadow.position.x -= gyat
			gyat += 1
		elif skibidi:
			$ColorRect.size.x += rizz
			$ColorRectShadow.size.x += rizz
			$Triangles.position.x += rizz
			$TrianglesShadow.position.x += rizz
			rizz += 1
			if rizz == 8:
				skibidi = false

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Stages/1.tscn")

func _on_stage_select_pressed():
	_pull_out()
	pass # Replace with function body.

func _on_options_pressed():
	_pull_out()
	pass # Replace with function body.

func _on_how_to_play_pressed():
	_pull_out()
	pass # Replace with function body.
	
func _on_credits_pressed():
	_pull_out()
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()

func _pull_out():
	pullOut = true
	pullIn = false
	gyat = 0
	rizz = 0

func _pull_in():
	pullOut = false
	pullIn = true
	gyat = 0
	rizz = 0
