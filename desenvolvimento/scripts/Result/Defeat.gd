extends Node2D

func _ready():
	$ScoreBar.value = Globals.score_phase_1
	var result := float(Globals.score_phase_1 * 100) / float(Globals.max_score_phase_1)
	$FinalScore.text = ("%00.0f" % result) + "%"


# PT_BR: Abre a cena de Fases
# EN_US: Open the phases scene
func _on_BackButton_pressed():
	Globals.score_phase_1 = 0
	get_tree().change_scene("res://scenes/Phases.tscn")
