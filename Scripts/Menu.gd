extends Control

var down = 0

func _physics_process(_delta):
	
	down -= 0.15
	$Triangles.region_rect = Rect2(0, down, 16, 272)


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
