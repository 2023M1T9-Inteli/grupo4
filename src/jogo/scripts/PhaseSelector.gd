extends Node2D

onready var phase_1_musica = preload ("res://assets/Audio/music_phase_1.mp3")

func _ready():
	if Globals.player_score_phase_1 >= 56:
		$PhasesGridContainer/Phase2Button.texture_normal = load("res://assets/PhasesScreen/button_phase_2.png")
		$PhasesGridContainer/Phase2Button.texture_hover = load("res://assets/PhasesScreen/button_phase_2_dark.png")
  
	Audio.change_music(phase_1_musica)

# PT_BR: Abre a cena do level 1
# EN_US: Opens the level 1 scene
func _on_Phase1Button_pressed():
	get_tree().change_scene("res://scenes/Dialog/DialogScene1.tscn")


# PT_BR: Abre a cena do level 2 se o score é maior que 56%
# EN_US: Opens the level 2 scene if score bigger than 56%
func _on_Phase2Button_pressed():
	if Globals.player_score_phase_1 >= 56:
		get_tree().change_scene("res://scenes/Dialog/DialogScene2.tscn")


func _on_TextureButton_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")

