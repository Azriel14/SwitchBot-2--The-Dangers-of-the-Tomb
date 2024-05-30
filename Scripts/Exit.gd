extends CharacterBody2D

var enterable = false

func _opened():
	$Sprite.frame = 1
	enterable = true

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		if enterable == true:
			Singleton._increment_stage()
			get_tree().change_scene_to_file("res://Scenes/Stages/Stage" + str(Singleton.stage) + ".tscn")
