extends PopupMenu


#PT_BR: Essa lista determina qual canal de áudio terá seu volume alterado
const bus_names = {
	master_bus = "Master",
	music_bus = "Music",
	sfx_bus = "SFX"
}


#PT_BR: Aqui o valor dos slider são atribuídos à globais
func _ready():
	$Master_slider.value = Audio.MasterValue
	$SliderMusic.value = Audio.MusicValue
	$SFX_slider.value = Audio.SfxValue
	
	#$Video.add_color_override("font_color", "#000000")


#PT_BR: Essa função seta o valor do nacal de áudio
func change_volume(BusName,ChangedValue):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(BusName), linear2db(ChangedValue))

# PT_BR: Volta para a cena do menu.
# EN_US: Goes back to the menu scene.
func _on_BackButton_pressed():
	self.hide()


# PT_BR: Essa função muda o volume do canal Master
func _on_Master_slider_value_changed(value):
	change_volume(bus_names.master_bus, value)
	Audio.MasterValue = value


# PT_BR: Essa função muda o volume do canal Music
func _on_SliderMusic_value_changed(value):
	change_volume(bus_names.music_bus, value)
	Audio.MusicValue = value


# PT_BR: Essa função muda o volume do canal SFX
func _on_SFX_slider_value_changed(value):
	change_volume(bus_names.sfx_bus, value)
	Audio.SfxValue = value


func _on_Video_pressed():
	$VolumeOptionLabel.visible = false
	$Master_slider.visible = false
	$SliderMusic.visible = false
	$VolumeOptionLabel2.visible = false
	$SFX_slider.visible = false
	$VolumeOptionLabel3.visible = false
