extends Node2D

func _ready():
#PT_BR: Define o valor da "$ScoreBar" como o score da fase um, além de calcular "result" e mostrar na tela
#EN_US: Defines the value of "$ScoreBar" as the score of phase one, also calculation the "result" and showing it on screen
	var result := float(Globals.score_phase_1 * 100) / float(Globals.max_score_phase_1)
	$ScoreBar.value = result
	$FinalScore.text = ("%00.0f" % result) + "%"


# PT_BR: Abre a cena de Fases e reinicia a variável "Global.score_phase_1"
# EN_US: Open the phases scene and resets the variable "Global.score_phase_1"
func _on_BackButton_pressed():
	Globals.score_phase_1 = 0
	var __ = get_tree().change_scene("res://scenes/Phases.tscn")

# PT_BR: Ao pressionar o botão, a fase recomeça.
# EN_US: When the button is pressed, the phase reset.
func _on_TextureButton_pressed():
	Globals.score_phase_1 = 0
	var __ = get_tree().change_scene("res://scenes/phase1/Phase1.tscn")
