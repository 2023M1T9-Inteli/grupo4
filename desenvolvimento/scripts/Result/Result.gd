extends Node2D

#PT/BR: Variáveis locais para o funcionamento da barra de progresso
#EN/US: Local variables used for the progress bar to work
onready var result_description = $ResultDescription
onready var score_bar = $ScoreBar
onready var star1 = $ScoreBar/StarFull1
onready var star2 = $ScoreBar/StarFull2
onready var star3 = $ScoreBar/StarFull3
var result := 0.0
var count = 0

#PT/BR: Variáveis para pré-carregar assets de outras pastas
#EN/US: Variables to preload assets from other files
var green_bar = preload("res://assets/Feedbacks/progress_bars/progress_bar_full_green.png")
var yellow_bar = preload("res://assets/Feedbacks/progress_bars/progress_bar_full_yellow.png")
var paula_bad = preload("res://assets/Feedbacks/paula_bad.png")
var paula_low = preload("res://assets/Feedbacks/paula low.png")
var paula_medium = preload("res://assets/Feedbacks/paula_médio.png")
var paula_execelent = preload("res://assets/Feedbacks/paula_excelente.png")

#PT/BR: Constante de dicionário que armazena as falas de cada feedback
#EN/US: Dictionary constant that has the speechs from all feedbacks
const results_texts: Dictionary = {
	0: 'Você está com dificuldades para identificar o nível de competência, motivação e preparo das pessoas da equipe para delegar tarefas de acordo com essas referências. Sem isso, além de não ter as tarefas executadas adequadamente, pode não estar desenvolvendo o time. :(',
	1: 'Uhu! Você atingiu a meta mínima de acerto na delegação de tarefas de acordo com o nível de competência, motivação e preparo das pessoas. É importante manter sua atenção na qualidade da entrega, perguntas que são feitas, interesse pelo "negócio" da empresa e área de conhecimento de todas as pessoas. Com isso, seus acertos no momento de relacionar pessoas e tarefas vai aumentar e os resultados também!',
	2: 'Yes! Você mostrou-se um líder capaz de identificar o nível de competência, motivação e preparo de várias pessoas da equipe para delegar tarefas de acordo com essas referências! As tarefas da área tendem a ser entregues dentro dos padrões de qualidade esperados e, com isso, você desenvolve o time para que consiga atender demandas cada vez mais complexas.',
	3: 'Parabéns! Seu grau de acerto em identificar o nível de competência, motivação e preparo da equipe para delegar tarefas de acordo com essas referências é excelente! Você está promovendo excelência nas entregas do time, desenvolvendo as habilidades deles. O proximo passo é delegar tarefas que desafiem as competências atuais de forma que as pessoas possam ir além. O nível de motivação de cada pessoa pode ser um bom indicativo.'
}

func _ready():
	#PT/BR: Define uma variável "result" como o resultado de uma operação entre os scores da fase
	#EN/US: Defines a variable "result" as the result of a operation between the phase scores
	result = float(Globals.score_phase_1 * 100) / float(Globals.max_score_phase_1)
	$FinalScore.text = ("%00.0f" % result) + "%"	
	
	#PT/BR: Defina qual texto e sprite irá aparecer de acordo com o valor da variável "result"
	#EN/US: Defines which text and sprite will show according to the value os the variable "result"
	if result < 56 :
		result_description.bbcode_text = results_texts[0]
		$PaulaSprite.texture = paula_bad
	elif result < 73:
		result_description.bbcode_text = results_texts[1]
		$PaulaSprite.texture = paula_low
	elif result < 85:
		result_description.bbcode_text = results_texts[2]
		$PaulaSprite.texture = paula_medium
	else:
		result_description.bbcode_text = results_texts[3]
		$PaulaSprite.texture = paula_execelent

func _process(delta):
	#PT/BR: Muda a cor da barra de progresso de acordo com a variável "count"
	#EN/US: Changes the bar's color accordign to the variable "count"
	if count < 1:
		_change_bar()
		count += 1

#PT/BR: Função que enche as estrelas de acordo com o progresso da barra
#EN/US: Function that fullfil the strars according to the bar's progress
func _change_bar():
	#PT/BR: Enquanto "count" foi menor ou igual a "result", a estrela compara o valor de "result" e define o quão será preenchida
	#EN/US(1): While "count" is lower or equal to "result", the star compares the value of "result" and defunes how much the
	#EN/US(2): will be fullfield
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

#PT/BR: Função da "StarFull1" que troca a cor da barra e toca um audio
#EN/US: Function from "StarFull1" that changes the bar color and plays an audio
func _on_StarFull1_completed_change(_texture_progress_node):
	score_bar.texture_progress = yellow_bar
	$ScoreBar/StarFull1/Audio_1_star.play()

#PT/BR: Função da "StarFull2" que toca um audio
#EN/US: Function from "StarFull2" that plays an audio
func _on_StarFull2_completed_change(_texture_progress_node):
	$ScoreBar/StarFull2/Audio_2_star.play()

#PT/BR: Função da "StarFull3" que troca a cor da barra e toca um audio
#EN/US: Function from "StarFull3" that changes the bar color and plays an audio
func _on_StarFull3_completed_change(_texture_progress_node):
	score_bar.texture_progress = green_bar
	$ScoreBar/StarFull3/Audio_3_star.play()

