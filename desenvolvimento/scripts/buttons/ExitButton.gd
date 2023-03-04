extends Button

# PT_BR: Ao clicar o jogo fechará
# EN_US: By clicking the game will close
func _on_HoverExitButton_pressed():
	get_tree().quit()
