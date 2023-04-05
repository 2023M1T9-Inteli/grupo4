extends TextureButton

# PT_BR: Quando o botão for pressionado, o jogo será fechado.
# EN_US: When the button is pressed, the game will be closed.
func _on_ExitButton_pressed():
	get_tree().quit()
