extends Control

var master_bus = AudioServer.get_bus_index("Master")

# PT_BR: Controla o volume da música e a muta 
# EN_US: Controls music volume and mute
func _on_SliderMusic_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -40:
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus,false)
