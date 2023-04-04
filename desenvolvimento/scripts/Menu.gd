extends Control


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
	$Credits.show()


# PT_BR: Chama a função change_music assim que a cena é iniciada.
# EN_US: Call the change_music function when the scene is initiated.
func _ready():
	Audio.change_music(Audio.menu_music)


# PT_BR: Quando o botão for pressionado, o jogo será fechado.
# EN_US: When the button is pressed, the game will be closed.
func _on_ExitButton_pressed():
	get_tree().quit()
