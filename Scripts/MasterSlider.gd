extends HSlider

func _value_changed(newValue):
	var masterIndex= AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(masterIndex, linear_to_db(newValue))
