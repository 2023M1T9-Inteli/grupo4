extends Control

# PT_BR: Obtém o controlador da música
# EN_US: Get the music control
var master_bus = AudioServer.get_bus_index("Master")

func _ready():
	# PT_BR: Sincroniza o slider com o volume da música ao abrir
	# EN_US: Sync slider to music volume when opening
	$VolumeGrid/SliderMusic.value = AudioServer.get_bus_volume_db(master_bus)

# PT_BR: Controla o volume da música e a muta 
# EN_US: Controls music volume and mute
func _on_SliderMusic_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	print(value)
	if value == -40:
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus,false)

# PT_BR: Abre a cena do menu
# EN_US: Open the menu scene
func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
