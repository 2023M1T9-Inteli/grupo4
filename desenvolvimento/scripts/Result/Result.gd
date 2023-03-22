extends Node2D

onready var result_description = $ResultDescription
var paula_bad = preload("res://assets/Feedbacks/paula_bad.png")
var paula_low = preload("res://assets/Feedbacks/paula low.png")
var paula_medium = preload("res://assets/Feedbacks/paula_médio.png")
var paula_execelent = preload("res://assets/Feedbacks/paula_excelente.png")

const results_texts: Dictionary = {
	0: 'Você está com dificuldades para identificar o nível de competência, motivação e preparo das pessoas da equipe para delegar tarefas de acordo com essas referências. Sem isso, além de não ter as tarefas executadas adequadamente, pode não estar desenvolvendo o time. :(',
	1: 'Uhu! Você atingiu a meta mínima de acerto na delegação de tarefas de acordo com o nível de competência, motivação e preparo das pessoas. É importante manter sua atenção na qualidade da entrega, perguntas que são feitas, interesse pelo "negócio" da empresa e área de conhecimento de todas as pessoas. Com isso, seus acertos no momento de relacionar pessoas e tarefas vai aumentar e os resultados também!',
	2: 'Yes! Você mostrou-se um líder capaz de identificar o nível de competência, motivação e preparo de várias pessoas da equipe para delegar tarefas de acordo com essas referências! As tarefas da área tendem a ser entregues dentro dos padrões de qualidade esperados e, com isso, você desenvolve o time para que consiga atender demandas cada vez mais complexas.',
	3: 'Parabéns! Seu grau de acerto em identificar o nível de competência, motivação e preparo das pessoas da equipe para delegar tarefas de acordo com essas referências é excelente! Você está promovendo excelência nas entregas do time, desenvolvendo as habilidades deles. O proximo passo é delegar tarefas que desafiem as competências atuais de forma que as pessoas possam ir além. O nível de motivação de cada pessoa pode ser um bom indicativo.'
}
func _ready():
	var result := float(Globals.score_phase_1 * 100) / float(Globals.max_score_phase_1)
	$ScoreBar.value = result
	$FinalScore.text = ("%00.0f" % result) + "%"
	
	
	if result < 56 :
		result_description.bbcode_text = results_texts[0]
		$PaulaSprite.texture = paula_bad
	elif result < 73:
		result_description.bbcode_text = results_texts[1]
		$StarEmpty1.value = 100
		$PaulaSprite.texture = paula_low
	elif result < 85:
		result_description.bbcode_text = results_texts[2]
		$StarEmpty1.value = 100
		$StarEmpty2.value = 100
		$PaulaSprite.texture = paula_medium
	elif result < 100:
		result_description.bbcode_text = results_texts[3]
		$StarEmpty1.value = 100
		$StarEmpty2.value = 100
		$StarEmpty3.value = 100
		$PaulaSprite.texture = paula_execelent


# PT_BR: Abre a cena de Fases
# EN_US: Open the phases scene
func _on_BackButton_pressed():
	Globals.score_phase_1 = 0
	get_tree().change_scene("res://scenes/Phases.tscn")
