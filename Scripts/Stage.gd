extends TileMap

func _physics_process(_delta):
	var player = $"../Player"
	var tilePos = local_to_map(to_local(player.global_position))
	var tileData = get_cell_tile_data(0, tilePos)
	
	if tileData and tileData.get_custom_data("isSpike"):
		player._death()
