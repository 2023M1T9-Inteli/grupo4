extends Node2D

onready var result_description = $ResultDescription
onready var score_bar = $ScoreBar
onready var star1 = $ScoreBar/StarFull1
onready var star2 = $ScoreBar/StarFull2
onready var star3 = $ScoreBar/StarFull3

var green_bar = preload("res://assets/Feedbacks/progress_bars/progress_bar_full_green.png")
var yellow_bar = preload("res://assets/Feedbacks/progress_bars/progress_bar_full_yellow.png")

var paula_time = preload("res://assets/Feedbacks/paula_time.png")

var result := 0.0
var count = 0

const results_texts: Dictionary = {
	0: 'Que pena! Infelizmente você não conseguiu delegar todas as tarefas a tempo. Tente não acumular tarefas para apenas um funcionário, enquanto exitem outros disponíveis. Com isso, sua delegação de tarefas pode se tornar mais eficiente e você poderá obter melhores resultados!',
}
func _ready():
	result = float(Globals.score_phase_1 * 100) / float(Globals.max_score_phase_1)
	$FinalScore.text = ("%00.0f" % result) + "%"	
	
	if result > 56 :
		result_description.bbcode_text = results_texts[0]
		$PaulaSprite.texture = paula_time
		
	

func _process(delta):
	if count < 1:
		_change_bar()
		count += 1


func _change_bar():
	while count <= result:
		score_bar.value = count
		if count > 53:
			star1.change_value(clamp((result - 53), 0, 3)) 
		if count > 69:
			star2.change_value(clamp((result - 69), 0, 4))
		if count > 81:
			star3.change_value(clamp((result - 81), 0, 4))
		count += 1
		yield(get_tree().create_timer(0.01), "timeout")

# PT_BR: Abre a cena de Fases
# EN_US: Open the phases scene
func _on_BackButton_pressed():
	Globals.player_score_phase_1 = Globals.score_phase_1
	Globals.score_phase_1 = 0
	get_tree().change_scene("res://scenes/Phases.tscn")


func _on_StarFull1_completed_change(texture_progress_node):
	score_bar.texture_progress = yellow_bar
	$ScoreBar/StarFull1/Audio_1_star.play()


func _on_StarFull2_completed_change(texture_progress_node):
	$ScoreBar/StarFull2/Audio_2_star.play()


func _on_StarFull3_completed_change(texture_progress_node):
	score_bar.texture_progress = green_bar
	$ScoreBar/StarFull3/Audio_3_star.play()

