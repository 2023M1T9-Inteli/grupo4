extends Node2D


func _ready():
	pass
# PT_BR: Abre a cena do level 1
# EN_US: Opens the level 1 scene
func _on_Phase1Button_pressed():
	get_tree().change_scene("res://scenes/Dialog/DialogScene1.tscn")


func _on_Phase2Button_pressed():
	if Globals.player_score_phase_1 >= 850:
		get_tree().change_scene("res://scenes/Dialog/DialogScene1.tscn")
	else:
		pass
