extends Control

# PT_BR: Variável que carrega a música do jogo
# EN_US: Variable that loads the game music
var theme_music = preload("res://assets/Audio/main_music.mp3")


# PT_BR: Inicia o jogo abrindo o tutorial.
# EN_US: Start the game opening the tutorial.
func _on_StartButton_pressed():
	$TutorialPopup.open_tutorial()


# PT_BR: Abre a cena de opções.
# EN_US: Open the options scene.
func _on_OptionsButton_pressed():
	$Options.show()


# PT_BR: Abre a cena de créditos.
# EN_US: Opens the credits scene.
func _on_CreditsButton_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")


# PT_BR: Chama a função change_music assim que a cena é iniciada.
# EN_US: Call the change_music function when the scene is initiated.
func _ready():
	Audio.change_music(theme_music)
