extends PopupMenu

# PT_BR: Obtém o controlador da música.
# EN_US: Get the music control.
var master_bus = AudioServer.get_bus_index("Master")

func _ready():
	# PT_BR: Sincroniza o slider com o volume da música ao abrir.
	# EN_US: Sync slider to music volume when opening.
	$VolumeGrid/SliderMusic.value = AudioServer.get_bus_volume_db(master_bus)


# PT_BR (1): Controla o volume da música e a muta. 
# PT_BR (2): Parâmetro: value.
# EN_US (1): Controls music volume and mute.
# EN_US (2): Parameter: value.
func _on_SliderMusic_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == -40:
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus,false)


# PT_BR: Volta para a cena do menu.
# EN_US: Goes back to the menu scene.
func _on_BackButton_pressed():
	self.hide()
