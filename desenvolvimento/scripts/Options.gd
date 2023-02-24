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


# PT_BR: Abre a cena do menu
# EN_US: Open the menu scene
func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
