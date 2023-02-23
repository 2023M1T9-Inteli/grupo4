extends Node

# PT_BR: Variável que guarda a música do jogo
# EN_US: Variable that stores the game's music
var thememusic = load("res://assets/Audio/focus-loop-corporate-music-114297.mp3")

# PT_BR: Define a música e coloca para tocar
# EN_US: Set the music and play
func _play_music():
	$Music.stream = thememusic
	$Music.play()
