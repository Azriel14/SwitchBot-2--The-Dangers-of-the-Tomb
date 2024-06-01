extends Control

var stop
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

enum State {StageSelect, Options, HowToPlay, Credits, knull}
var state = State.knull

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
		if $ColorRect.size.x < 1050 && skibidi:
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

	if Input.get_action_strength("Back") && $ColorRect.size.x == 1050:
		stop = true

	match state:
		State.StageSelect:
			if stop && $ContentArea/StageSelect.position.x < 1150:
				$ContentArea/StageSelect.position.x += 50
				if $ContentArea/StageSelect.position.x == 1150 && $InTriangles.position.y < 545:
					$InTriangles.position.y += 4
					if $InTriangles.position.y == 544:
						$InTriangles.visible = false
						$InTrianglesShadow.visible = false
				if $ContentArea/StageSelect.position.x == 1150 && $InTriangles.visible == false:
					_pull_in()
			if !stop:
				if $ColorRect.size.x == 1050 && skibidi:
					$InTriangles.visible = true
					$InTrianglesShadow.visible = true
					if $InTriangles.position.y > 540:
						$InTriangles.position.y -= 1
					if $ContentArea/StageSelect.position.x > 0:
						$ContentArea/StageSelect.position.x -= 50
		State.Options:
			if stop && $ContentArea/Options.position.x < 1150:
				$ContentArea/Options.position.x += 50
				if $ContentArea/Options.position.x == 1150 && $InTriangles.position.y < 545:
					$InTriangles.position.y += 4
					if $InTriangles.position.y == 544:
						$InTriangles.visible = false
						$InTrianglesShadow.visible = false
				if $ContentArea/Options.position.x == 1150 && $InTriangles.visible == false:
					_pull_in()
			if !stop:
				if $ColorRect.size.x == 1050 && skibidi:
					$InTriangles.visible = true
					$InTrianglesShadow.visible = true
					if $InTriangles.position.y > 540:
						$InTriangles.position.y -= 1
					if $ContentArea/Options.position.x > 0:
						$ContentArea/Options.position.x -= 50
		State.HowToPlay:
			if stop && $ContentArea/HowToPlay.position.x < 1150:
				$ContentArea/HowToPlay.position.x += 50
				if $ContentArea/HowToPlay.position.x == 1150 && $InTriangles.position.y < 545:
					$InTriangles.position.y += 4
					if $InTriangles.position.y == 544:
						$InTriangles.visible = false
						$InTrianglesShadow.visible = false
				if $ContentArea/HowToPlay.position.x == 1150 && $InTriangles.visible == false:
					_pull_in()
			if !stop:
				if $ColorRect.size.x == 1050 && skibidi:
					$InTriangles.visible = true
					$InTrianglesShadow.visible = true
					if $InTriangles.position.y > 540:
						$InTriangles.position.y -= 1
					if $ContentArea/HowToPlay.position.x > 0:
						$ContentArea/HowToPlay.position.x -= 50
		State.Credits:
			if stop && $ContentArea/Credits.position.x < 1150:
				$ContentArea/Credits.position.x += 50
				if $ContentArea/Credits.position.x == 1150 && $InTriangles.position.y < 545:
					$InTriangles.position.y += 4
					if $InTriangles.position.y == 544:
						$InTriangles.visible = false
						$InTrianglesShadow.visible = false
				if $ContentArea/Credits.position.x == 1150 && $InTriangles.visible == false:
					_pull_in()
			if !stop:
				if $ColorRect.size.x == 1050 && skibidi:
					$InTriangles.visible = true
					$InTrianglesShadow.visible = true
					if $InTriangles.position.y > 540:
						$InTriangles.position.y -= 1
					if $ContentArea/Credits.position.x > 0:
						$ContentArea/Credits.position.x -= 50

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
	state = State.StageSelect
	_pull_out()

func _on_options_pressed():
	state = State.Options
	_pull_out()

func _on_how_to_play_pressed():
	state = State.HowToPlay
	_pull_out()
	
func _on_credits_pressed():
	state = State.Credits
	_pull_out()

func _on_quit_pressed():
	get_tree().quit()

func _pull_out():
	pullOut = true
	pullIn = false
	stop = false
	gyat = 0
	rizz = 0

func _pull_in():
	pullOut = false
	pullIn = true
	gyat = 0
	rizz = 0

# That sure is a stage slect
func _on_stage_1_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Stages/1.tscn")

func _on_stage_2_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Stages/2.tscn")

func _on_stage_3_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Stages/3.tscn")

func _on_stage_4_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Stages/4.tscn")

func _on_stage_5_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Stages/5.tscn")

func _on_stage_6_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Stages/6.tscn")

func _on_stage_7_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Stages/7.tscn")

func _on_stage_8_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Stages/8.tscn")

func _on_stage_9_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Stages/9.tscn")
