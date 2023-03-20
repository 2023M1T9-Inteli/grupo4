extends Node2D

func _ready():
	print(Globals.score_phase_1)
	print(Globals.max_score_phase_1)
	var result := float(Globals.score_phase_1 * 100) / float(Globals.max_score_phase_1)
	$ScoreBar.value = result
	$FinalScore.text = ("%00.0f" % result) + "%"

