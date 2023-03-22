extends Node


# PT_BR: Define a música e coloca para tocar
# EN_US: Set the music and play
func play_music(music):
	$Music.stream = music
	$Music.play()

func change_music(music):
	$Music.stop()
	play_music(music)
