extends Control

var stop
var back
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

@onready var logo = $Logo
@onready var buttons = $Buttons
@onready var triangles = $Triangles
@onready var colorRect = $ColorRect
@onready var logoShadow = $LogoShadow
@onready var inTriangles = $InTriangles
@onready var options = $ContentArea/Options
@onready var credits = $ContentArea/Credits
@onready var trianglesShadow = $TrianglesShadow
@onready var colorRectShadow = $ColorRectShadow
@onready var howToPlay = $ContentArea/HowToPlay
@onready var inTrianglesShadow = $InTrianglesShadow
@onready var stageSelect = $ContentArea/StageSelect

func _physics_process(delta):
	# Triangle go down
	down -= 0.15

	triangles.region_rect = Rect2(0, down, 16, 272)
	trianglesShadow.region_rect = Rect2(0, down, 16, 272)
	inTriangles.region_rect = Rect2(0, down + 8, 16, 272)
	inTrianglesShadow.region_rect = Rect2(0, down + 8, 16, 272)

	# Logo wobble
	timePassed += delta

	var xOffset = sin(timePassed * wobbleSpeedX) * wobbleAmplitudeX
	var yOffset = sin(timePassed * wobbleSpeedY) * wobbleAmplitudeY

	logo.position.x += xOffset
	logo.position.y += yOffset
	logoShadow.position.x += xOffset
	logoShadow.position.y += yOffset

	# Feckin' sick menu animation
	if pullOut:
		if colorRect.size.x < 1050 and skibidi:
			logo.position.x -= gyat
			logoShadow.position.x -= gyat
			buttons.position.x -= gyat
			colorRect.size.x += gyat
			colorRectShadow.size.x += gyat
			triangles.position.x += gyat
			trianglesShadow.position.x += gyat
			gyat += 1
		elif not skibidi:
			colorRect.size.x -= rizz
			colorRectShadow.size.x -= rizz
			triangles.position.x -= rizz
			trianglesShadow.position.x -= rizz
			rizz += 1
			if rizz == 8:
				skibidi = true

	if Input.get_action_strength("Back") or back and colorRect.size.x == 1050:
		stop = true

	match state:
		State.StageSelect:
			if stop and stageSelect.position.x < 1150:
				stageSelect.position.x += 50
				if stageSelect.position.x == 1150 and inTriangles.position.y < 545:
					inTriangles.position.y += 4
					if inTriangles.position.y == 544:
						inTriangles.visible = false
						inTrianglesShadow.visible = false
				if stageSelect.position.x == 1150 and not inTriangles.visible:
					_pull_in()
			if not stop:
				if colorRect.size.x == 1050 and skibidi:
					inTriangles.visible = true
					inTrianglesShadow.visible = true
					if inTriangles.position.y > 540:
						inTriangles.position.y -= 1
					if stageSelect.position.x > 0:
						stageSelect.position.x -= 50
		State.Options:
			if stop and options.position.x < 1150:
				options.position.x += 50
				if options.position.x == 1150 and inTriangles.position.y < 545:
					inTriangles.position.y += 4
					if inTriangles.position.y == 544:
						inTriangles.visible = false
						inTrianglesShadow.visible = false
				if options.position.x == 1150 and not inTriangles.visible:
					_pull_in()
			if not stop:
				if colorRect.size.x == 1050 and skibidi:
					inTriangles.visible = true
					inTrianglesShadow.visible = true
					if inTriangles.position.y > 540:
						inTriangles.position.y -= 1
					if options.position.x > 0:
						options.position.x -= 50
		State.HowToPlay:
			if stop and howToPlay.position.x < 1150:
				howToPlay.position.x += 50
				if howToPlay.position.x == 1150 and inTriangles.position.y < 545:
					inTriangles.position.y += 4
					if inTriangles.position.y == 544:
						inTriangles.visible = false
						inTrianglesShadow.visible = false
				if howToPlay.position.x == 1150 and not inTriangles.visible:
					_pull_in()
			if not stop:
				if colorRect.size.x == 1050 and skibidi:
					inTriangles.visible = true
					inTrianglesShadow.visible = true
					if inTriangles.position.y > 540:
						inTriangles.position.y -= 1
					if howToPlay.position.x > 0:
						howToPlay.position.x -= 50
		State.Credits:
			if stop and credits.position.x < 1150:
				credits.position.x += 50
				if credits.position.x == 1150 and inTriangles.position.y < 545:
					inTriangles.position.y += 4
					if inTriangles.position.y == 544:
						inTriangles.visible = false
						inTrianglesShadow.visible = false
				if credits.position.x == 1150 and not inTriangles.visible:
					_pull_in()
			if not stop:
				if colorRect.size.x == 1050 and skibidi:
					inTriangles.visible = true
					inTrianglesShadow.visible = true
					if inTriangles.position.y > 540:
						inTriangles.position.y -= 1
					if credits.position.x > 0:
						credits.position.x -= 50

	if pullIn:
		if colorRect.size.x > 448 and not skibidi:
			logo.position.x += gyat
			logoShadow.position.x += gyat
			buttons.position.x += gyat
			colorRect.size.x -= gyat
			colorRectShadow.size.x -= gyat
			triangles.position.x -= gyat
			trianglesShadow.position.x -= gyat
			gyat += 1
		elif skibidi:
			colorRect.size.x += rizz
			colorRectShadow.size.x += rizz
			triangles.position.x += rizz
			trianglesShadow.position.x += rizz
			rizz += 1
			if rizz == 8:
				skibidi = false

func _on_start_pressed():
	get_tree().paused = false
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
	back = false
	gyat = 0
	rizz = 0

func _pull_in():
	pullOut = false
	pullIn = true
	gyat = 0
	rizz = 0

# That sure is a stage select
func _on_stage_1_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Stages/1.tscn")

func _on_stage_2_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Stages/2.tscn")

func _on_stage_3_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Stages/3.tscn")

func _on_stage_4_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Stages/4.tscn")

func _on_stage_5_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Stages/5.tscn")

func _on_stage_6_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Stages/6.tscn")

func _on_stage_7_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Stages/7.tscn")

func _on_stage_8_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Stages/8.tscn")

func _on_stage_9_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Stages/9.tscn")

# That sure is a back button
func _on_stage_select_back_button_pressed():
	back = true

func _on_options_back_button_pressed():
	back = true

func _on_how_to_play_back_button_pressed():
	back = true

func _on_credits_back_button_pressed():
	back = true

