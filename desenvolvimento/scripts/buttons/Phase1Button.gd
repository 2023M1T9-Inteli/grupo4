extends Button

# PT_BR: Abre a cena do level 1.
# EN_US: Opens the level 1 scene.
func _on_Phase1Button_pressed():
	get_tree().change_scene("res://scenes/Dialog/DialogScene1.tscn")
