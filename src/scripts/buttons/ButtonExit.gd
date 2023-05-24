extends Button

# PT_BR: Quando o botão for pressionado, o jogo irá carregar a cena Menu.
# EN_US: When the button is pressed, the game will load the Menu scene.
func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
