extends Node

# PT_BR: Variável que carrega a música do jogo
# EN_US: Variable that loads the game's music
var thememusic = load("res://assets/Audio/main_music.mp3")

# PT_BR: Define a música e coloca para tocar
# EN_US: Set the music and play
func _play_music():
	$Music.stream = thememusic
	$Music.play()
