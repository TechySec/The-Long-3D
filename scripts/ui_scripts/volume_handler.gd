extends TabBar

func _on_master_slider_value_changed(value: float) -> void:
	var bus_idx := AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(value))


func _on_sound_slider_value_changed(value: float) -> void:
	var bus_idx := AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(value))


func _on_music_slider_value_changed(value: float) -> void:
	var bus_idx := AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(value))
