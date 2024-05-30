extends TileMap

func _physics_process(_delta):
# Standing on spike = :(
	var player = $"../Player"
	var tilePosisition = local_to_map(to_local(player.global_position))
	var tileData = get_cell_tile_data(0, tilePosisition)
	
	if tileData and tileData.get_custom_data("isSpike"):
		player._death()
