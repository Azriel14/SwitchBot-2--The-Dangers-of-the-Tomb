extends CharacterBody2D

func _activated():
	$Sprite.frame = 1
	$"../Exit"._opened()
