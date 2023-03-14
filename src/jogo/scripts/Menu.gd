extends Control


# PT_BR: Inicia o jogo
# EN_US: Start the game
func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/Phases.tscn")


# PT_BR: Abre a cena de opções
# EN_US: Open the options scene
func _on_OptionsButton_button_up():
	get_tree().change_scene("res://scenes/Options.tscn")


# PT_BR: Abre a cena de créditos
# EN_US: Opens the credits scene
func _on_CreditsButton_button_up():
	get_tree().change_scene("res://scenes/Credits.tscn")
