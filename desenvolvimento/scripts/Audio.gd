extends Node

# PT_BR: Variável que carrega a música do jogo
# EN_US: Variable that loads the game's music
var theme_music = preload("res://assets/Audio/main_music.mp3")

# PT_BR: Define a música e coloca para tocar
# EN_US: Set the music and play
func play_music(music):
	$Music.stream = music
	$Music.play()

func change_music(music):
	$Music.stop()
	play_music(music)
