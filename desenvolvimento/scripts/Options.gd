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
	
	$FullScreen.visible = false
	$CheckBoxFullScreen.visible = false


#PT_BR: Essa função seta o valor do nacal de áudio
# EN_US:
func change_volume(BusName,ChangedValue):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(BusName), linear2db(ChangedValue))

# PT_BR: Volta para a cena do menu.
# EN_US: Goes back to the menu scene.
func _on_BackButton_pressed():
	self.hide()


# PT_BR: Essa função muda o volume do canal Master
# EN_US: 
func _on_Master_slider_value_changed(value):
	change_volume(bus_names.master_bus, value)
	Audio.MasterValue = value


# PT_BR: Essa função muda o volume do canal Music
# EN_US:
func _on_SliderMusic_value_changed(value):
	change_volume(bus_names.music_bus, value)
	Audio.MusicValue = value


# PT_BR: Essa função muda o volume do canal SFX
# EN_US: 
func _on_SFX_slider_value_changed(value):
	change_volume(bus_names.sfx_bus, value)
	Audio.SfxValue = value


# PT_BR: Função que oculta os itens quando o botão de vídeo é clicado
# EN_US: 
func _on_Video_pressed():
	$Video.add_color_override("font_color", "#f97171")
	$Volume.add_color_override("font_color", "#ebd9d9")
	$VolumeOptionLabel.visible = false
	$Master_slider.visible = false
	$SliderMusic.visible = false
	$VolumeOptionLabel2.visible = false
	$SFX_slider.visible = false
	$VolumeOptionLabel3.visible = false
	$FullScreen.visible = true
	$CheckBoxFullScreen.visible = true


# PT_BR: Função que oculta os itens quando o botão de volume é clicado
# EN_US: 
func _on_Volume_pressed():
	$Volume.add_color_override("font_color", "#f97171")
	$Video.add_color_override("font_color", "#ebd9d9")
	$VolumeOptionLabel.visible = true
	$Master_slider.visible = true
	$SliderMusic.visible = true
	$VolumeOptionLabel2.visible = true
	$SFX_slider.visible = true
	$VolumeOptionLabel3.visible = true
	$FullScreen.visible = false
	$CheckBoxFullScreen.visible = false


# PT_BR: Função que deixa a tela cheia quando o checkbox é selecionado
# EN_US: 
func _on_CheckBoxFullScreen_pressed():
	OS.window_fullscreen = not OS.window_fullscreen
