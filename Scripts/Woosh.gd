extends Sprite2D

var down = 0

func _physics_process(_delta):
	
	down -= 1
	region_rect = Rect2(0, down, 16, 272)
