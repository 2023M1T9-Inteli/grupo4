extends PopupMenu

const bus_names = {
	master_bus = "Master",
	music_bus = "Music",
	sfx_bus = "SFX"
}

func _ready():
	load_buses()
	
func load_buses():
	$VolumeGrid/Master_slider.value = linear2db(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus_names.master_bus)))
	$VolumeGrid2/SliderMusic.value = linear2db(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus_names.music_bus)))
	$VolumeGrid3/SFX_slider.value = linear2db(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus_names.sfx_bus)))


func change_volume(BusName,ChangedValue):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(BusName), linear2db(ChangedValue))

# PT_BR: Volta para a cena do menu.
# EN_US: Goes back to the menu scene.
func _on_BackButton_pressed():
	self.hide()


func _on_Master_slider_value_changed(value):
	change_volume(bus_names.master_bus, value)


func _on_SliderMusic_value_changed(value):
	change_volume(bus_names.music_bus, value)



func _on_SFX_slider_value_changed(value):
	change_volume(bus_names.sfx_bus, value)
