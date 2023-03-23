extends Node2D

onready var phase_1_musica = preload ("res://assets/Audio/music_phase_1.mp3")

var result = 0

func _ready():
	result = float(Globals.score_phase_1 * 100) / float(Globals.max_score_phase_1)
	if result >= 56:
		$PhasesGridContainer/Phase2Button.icon = load("res://assets/PhasesScreen/button_phase_2.png")
  
	Audio.change_music(phase_1_musica)

# PT_BR: Abre a cena do level 1
# EN_US: Opens the level 1 scene
func _on_Phase1Button_pressed():
	get_tree().change_scene("res://scenes/Dialog/DialogScene1.tscn")


# PT_BR: Abre a cena do level 2 se o score é maior que 56%
# EN_US: Opens the level 2 scene if score bigger than 56%
func _on_Phase2Button_pressed():
	if result >= 56:
		get_tree().change_scene("res://scenes/Dialog/DialogScene2.tscn")
