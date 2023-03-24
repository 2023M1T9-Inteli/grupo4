extends Control

# PT_BR: Variável que carrega a música do jogo
# EN_US: Variable that loads the game's music
var theme_music = preload("res://assets/Audio/main_music.wav")

# PT_BR: Inicia o tutorial
# EN_US: Start the tutorial
func _on_StartButton_pressed():
	$TutorialPopup.open_tutorial()


# PT_BR: Abre a cena de opções
# EN_US: Open the options scene
func _on_OptionsButton_pressed():
	$Options.show()


# PT_BR: Abre a cena de créditos
# EN_US: Opens the credits scene
func _on_CreditsButton_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")


func _ready():
	Audio.change_music(theme_music)
