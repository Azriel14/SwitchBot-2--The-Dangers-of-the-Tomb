extends HSlider

func _value_changed(newValue):
	var SFXIndex= AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(SFXIndex, linear_to_db(newValue))
