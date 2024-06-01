extends HSlider

func _value_changed(newValue):
	var musicIndex= AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(musicIndex, linear_to_db(newValue))
