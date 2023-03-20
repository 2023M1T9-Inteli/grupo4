extends Node2D

onready var result_description = $ResultDescription

const results_texts: Dictionary = {
	0: 'Você está com dificuldades para identificar o nível de competência, motivação e preparo das pessoas da equipe para delegar tarefas de acordo com essas referências. Sem isso, além de não ter as tarefas executadas adequadamente, pode não estar desenvolvendo o time. :(',
	1: 'Uhu! Você atingiu a meta mínima de acerto na delegação de tarefas de acordo com o nível de competência, motivação e preparo das pessoas. É importante manter sua atenção na qualidade da entrega, perguntas que são feitas, interesse pelo "negócio" da empresa e área de conhecimento de todas as pessoas. Com isso, seus acertos no momento de relacionar pessoas e tarefas vai aumentar e os resultados também!',
	2: 'Yes! Você mostrou-se um líder capaz de identificar o nível de competência, motivação e preparo de várias pessoas da equipe para delegar tarefas de acordo com essas referências! As tarefas da área tendem a ser entregues dentro dos padrões de qualidade esperados e, com isso, você desenvolve o time para que consiga atender demandas cada vez mais complexas.',
	3: 'Parabéns! Seu grau de acerto em identificar o nível de competência, motivação e preparo das pessoas da equipe para delegar tarefas de acordo com essas referências é excelente! Você está promovendo excelência nas entregas do time, desenvolvendo as habilidades deles. O proximo passo é delegar tarefas que desafiem as competências atuais de forma que as pessoas possam ir além. O nível de motivação de cada pessoa pode ser um bom indicativo.'
}
func _ready():
	print(Globals.score_phase_1)
	print(Globals.max_score_phase_1)
	var result := float(Globals.score_phase_1 * 100) / float(Globals.max_score_phase_1)
	$ScoreBar.value = result
	$FinalScore.text = ("%00.0f" % result) + "%"
	
	
	if result < 56:
		result_description.bbcode_text = results_texts[0]
	elif result < 73:
		result_description.bbcode_text = results_texts[1]
		$StarEmpty1.value = 100
	elif result < 85:
		result_description.bbcode_text = results_texts[2]
		$StarEmpty1.value = 100
		$StarEmpty2.value = 100
	elif result < 100:
		result_description.bbcode_text = results_texts[3]
		$StarEmpty1.value = 100
		$StarEmpty2.value = 100
		$StarEmpty3.value = 100