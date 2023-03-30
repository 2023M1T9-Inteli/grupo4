extends Node

# PT_BR: Variáveis para armazenar onde a música parou
# EN_US: Variable to store where the music paused
var temp = 0.0

# PT_BR: Variáveis para armazenar as músicas do jogo
# EN_US: Variable to store the game musics
var menu_music = preload("res://assets/Audio/main_music.wav")
var music_phase_1 = load("res://assets/Audio/music_phase_1.mp3")
var music_phase_2 = load("res://assets/Audio/music/music_fase_2.wav")
var music_phase_3 = load("res://assets/Audio/music/musica_fase_3_2 (mp3cut.net).wav")
var final_music = load("res://assets/Audio/music/VictoryMusic (mp3cut.net).wav")

# PT_BR: Variáveis para armazenar todos os volumes do jogo
# EN_US: Variable to store the all the volumes of the game
var MasterValue = 1
var MusicValue = 1
var SfxValue = 1

onready var music_node = $Music

# PT_BR (1): Função que define a música e coloca para tocar. 
# PT_BR (2): Parâmetro: music - arquivo de música.
# EN_US (1): Set the music and play.
# EN_US (2): Parameter: music - arquivo de música.

func play_music(music_node):
	music_node.stream = music_node
	music_node.play()

# PT_BR (1): Função para trocar de música.
# PT_BR (2): Parâmetro: music - arquivo de música.
# EN_US (1): Function to change the music. Receives music as parameter.
# EN_US (2): Parameter: music - arquivo de música.
func change_music(music_node):
	if music_node != music_node.stream:
		music_node.stop()
		play_music(music_node)

# PT_BR: Função que continua a música
# EN_US: Function that resume the music
func resume():
	music_node.play()
	music_node.seek(temp)


# PT_BR: Função que pausa a música e salva onde parou
# EN_US: Function that pauses the music and saves where it stops
func stop():
	temp = music_node.get_playback_position()
	music_node.stop()


# PT_BR: Função que para a música
# EN_US: Function that stops the music
func pause_music():
	music_node.stop()
