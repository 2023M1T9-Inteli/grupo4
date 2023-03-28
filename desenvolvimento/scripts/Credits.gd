extends Control

# PT_BR: Abre a cena do menu.
# EN_US: Open the menu scene.
func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
