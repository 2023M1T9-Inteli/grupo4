extends Node2D

# PT_BR: Variável usada para armazenar o resultado do jogador na fase.
# EN_US: Variable used to store the player's result in the phase.
var result = 0

# PT_BR (1): Função usada para calcular o resultado e se for >=56, carregar o ícone 
# PT_BR (2): da segunda fase no botão e chamar a função change_music para trocar a música.
# EN_US (1): Function used to calculate the result and if it is >=56, load the second
# EN_US (2); phase's icon in the button and call the function change_music to change the music.
func _ready():
	Audio.stop()
	if Globals.player_phase_score["phase1"] >= 56:
		$PhasesGridContainer/Phase2Button.texture_normal = load("res://assets/PhasesScreen/button_phase_2.png")
		$PhasesGridContainer/Phase2Button.texture_hover = load("res://assets/PhasesScreen/button_phase_2_dark.png")

# PT_BR: Abre a cena da primeira fase.
# EN_US: Opens the first phase scene.
func _on_Phase1Button_pressed():
	var __ = get_tree().change_scene("res://scenes/Dialog/DialogScene1.tscn")


# PT_BR: Abre a cena da segunda fase se o score é maior que 56%.
# EN_US: Opens the phase two scene if score is bigger than 56%.
func _on_Phase2Button_pressed():
	if Globals.player_phase_score["phase1"] >= 56:
		var __ = get_tree().change_scene("res://scenes/Dialog/DialogScene2.tscn")


func _on_TextureButton_pressed():
	var __ = get_tree().change_scene("res://scenes/Menu.tscn")

