extends Node

var temp = 0.0

# PT_BR (1): Função que define a música e coloca para tocar. 
# PT_BR (2): Parâmetro: music - arquivo de música.
# EN_US (1): Set the music and play.
# EN_US (2): Parameter: music - arquivo de música.
func play_music(music):
	$Music.stream = music
	$Music.play()

# PT_BR (1): Função para trocar de música.
# PT_BR (2): Parâmetro: music - arquivo de música.
# EN_US (1): Function to change the music. Receives music as parameter.
# EN_US (2): Parameter: music - arquivo de música.
func change_music(music):
	if music != $Music.stream:
		$Music.stop()
		play_music(music)


func resume():
	$Music.play()
	$Music.seek(temp)


func pause():
	temp = $Music.get_playback_position()
	$Music.stop()

func pause_music(music):
	$Music.stop()
