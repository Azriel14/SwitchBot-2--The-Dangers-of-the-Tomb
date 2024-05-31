extends Control

var down = 0
var wobble_amplitude_x = 0.5
var wobble_amplitude_y = 0.25
var wobble_speed_x = 4
var wobble_speed_y = 6
var time_passed = 0

func _physics_process(delta):
# Triangle go down
	down -= 0.15

	$Triangles.region_rect = Rect2(0, down, 16, 272)
	$TrianglesShadow.region_rect = Rect2(0, down, 16, 272)

# Logo wobble
	time_passed += delta
	
	var x_offset = sin(time_passed * wobble_speed_x) * wobble_amplitude_x
	var y_offset = sin(time_passed * wobble_speed_y) * wobble_amplitude_y
	
	$Logo.position.x += x_offset
	$Logo.position.y += y_offset
	$LogoShadow.position.x += x_offset
	$LogoShadow.position.y += y_offset

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Stages/1.tscn")

func _on_stage_select_pressed():
	pass # Replace with function body.

func _on_options_pressed():
	pass # Replace with function body.

func _on_credits_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
