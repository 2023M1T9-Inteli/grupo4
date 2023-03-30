extends Node

var temp = 0.0

var MasterValue = 1
var MusicValue = 1
var SfxValue = 1

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

# PT_BR: Função que continua a música
# EN_US: Function that resume the music
func resume():
	$Music.play()
	$Music.seek(temp)


# PT_BR: Função que pausa a música e salva onde parou
# EN_US: Function that pauses the music and saves where it stops
func stop():
	temp = $Music.get_playback_position()
	$Music.stop()


# PT_BR: Função que para a música
# EN_US: Function that stops the music
func pause_music():
	$Music.stop()
