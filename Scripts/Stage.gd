extends TileMap

func _physics_process(_delta):
# Standing on spike = :(
	var playerPositionGlobal = $"../Player".global_position
	var playerPositionLocal = to_local(playerPositionGlobal)
	var tilePos = local_to_map(playerPositionLocal)

	var tileData = get_cell_tile_data(0, tilePos)
	
	if tileData != null:
		if tileData.get_custom_data("isSpike"):
			$"../Player"._death()
