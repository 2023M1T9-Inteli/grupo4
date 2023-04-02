extends PopupMenu


# PT_BR: Lista que determina qual o canal de áudio terá seu volume alterado
# EN_US: List that determines which audio channel will have its volume changed
const bus_names = {
	master_bus = "Master",
	music_bus = "Music",
	sfx_bus = "SFX"
}



# PT_BR(1): Assim que inicia o jogo, o valor dos sliders são atribuídos ao script global
# PT_BR(2): Os nós "FullScreen" e "CheckboxFullScreen" se tornam invisíveis 
# EN_US(1): As soon as you start the game, the value of the sliders are assigned to the global script
# EN_US(2): "FullScreen" and "CheckboxFullScreen" nodes become invisible
func _ready():
	$Master_slider.value = Audio.MasterValue
	$SliderMusic.value = Audio.MusicValue
	$SFX_slider.value = Audio.SfxValue
	$FullScreen.visible = false
	$CheckBoxFullScreen.visible = false
	$CheckBoxFullScreen.pressed = OS.window_fullscreen

# PT_BR(1): Função que seta o valor do canal de áudio
# PT_BR(2): Parâmetro 1: BusName - nome do canal de áudio
# PT_BR(3): Parâmetro 2: ChangedValue - valor alterado do volume
# EN_US(1): Function that sets the value of the audio channel
# EN_US(2): Parameter 1: BusName - audio channel name
# EN_US(3): Parameter 2: ChangedValue - changed volume value
func change_volume(BusName,ChangedValue):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(BusName), linear2db(ChangedValue))


# PT_BR: Volta para a cena do menu
# EN_US: Goes back to the menu scene
func _on_BackButton_pressed():
	self.hide()


# PT_BR(1): Função que muda o volume do canal Master
# PT_BR(2): Parâmetro: value - valor do volume
# EN_US(1): Function that changes the volume of the Master channel
# EN_US(2): Parameter: value - volume value
func _on_Master_slider_value_changed(value):
	change_volume(bus_names.master_bus, value)
	Audio.MasterValue = value


# PT_BR(1): Função que muda o volume do canal Music
# PT_BR(2): Parâmetro: value - valor do volume
# EN_US(1): Function that changes the volume of the Music channel
# EN_US(2): Parameter: value - volume value
func _on_SliderMusic_value_changed(value):
	change_volume(bus_names.music_bus, value)
	Audio.MusicValue = value


# PT_BR(1): Função que muda o volume do canal SFX
# PT_BR(2): Parâmetro: value - valor do volume
# EN_US(1): Function that changes the volume of the SFX channel
# EN_US(2): Parameter: value - volume value
func _on_SFX_slider_value_changed(value):
	change_volume(bus_names.sfx_bus, value)
	Audio.SfxValue = value


# PT_BR: Função que oculta os itens quando o botão de vídeo é clicado
# EN_US: Function that hides items when video button is clicked
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
# EN_US: Function that hides items when the volume button is clicked
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
# EN_US: Function that leaves the full screen when the checkbox is selected
func _on_CheckBoxFullScreen_pressed():
	Globals.change_window_fullscreen()
