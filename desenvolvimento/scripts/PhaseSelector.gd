extends Node2D

# PT_BR: Variável que carrega a música da primeira fase.
# EN_US: Variable that loads the phase one music.
onready var phase_1_musica = preload ("res://assets/Audio/music_phase_1.mp3")

# PT_BR: Variável usada para armazenar o resultado do jogador na fase.
# EN_US: Variable used to store the player's result in the phase.
var result = 0

# PT_BR (1): Função usada para calcular o resultado e se for >=56, carregar o ícone 
# PT_BR (2): da segunda fase no botão e chamar a função change_music para trocar a música.
# EN_US (1): Function used to calculate the result and if it is >=56, load the second
# EN_US (2); phase's icon in the button and call the function change_music to change the music.
func _ready():
	result = float(Globals.score_phase_1 * 100) / float(Globals.max_score_phase_1)
	if result >= 56:
		$PhasesGridContainer/Phase2Button.icon = load("res://assets/PhasesScreen/button_phase_2.png")
  
	Audio.change_music(phase_1_musica)

# PT_BR: Abre a cena da primeira fase.
# EN_US: Opens the phase one scene.
func _on_Phase1Button_pressed():
	get_tree().change_scene("res://scenes/Dialog/DialogScene1.tscn")


# PT_BR: Abre a cena da segunda fase se o score é maior que 56%.
# EN_US: Opens the phase two scene if score is bigger than 56%.
func _on_Phase2Button_pressed():
	if result >= 56:
		get_tree().change_scene("res://scenes/Dialog/DialogScene2.tscn")
