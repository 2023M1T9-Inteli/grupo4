extends Control


# PT_BR: Inicia o jogo
# EN_US: Start the game
func _on_HoverStartButton_pressed():
	get_tree().change_scene("res://scenes/Phases.tscn")


# PT_BR: Abre a cena de opções
# EN_US: Open the options scene
func _on_HoverOptionsButton_pressed():
	get_tree().change_scene("res://scenes/Options.tscn")


# PT_BR: Abre a cena de créditos
# EN_US: Opens the credits scene
func _on_HoverCreditsButton_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")
