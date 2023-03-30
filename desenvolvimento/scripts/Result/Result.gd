extends Node2D

# PT_BR: Guarda os objetos da cena para poder personalizar o feedback
# EN_US: Stores the scene objects for customize the feedback
onready var result_description = $ResultDescription
onready var score_bar = $ScoreBar
onready var star1 = $ScoreBar/StarFull1
onready var star2 = $ScoreBar/StarFull2
onready var star3 = $ScoreBar/StarFull3
onready var audio_star1 = $ScoreBar/StarFull1/AudioStar1
onready var audio_star2 = $ScoreBar/StarFull2/AudioStar2
onready var audio_star3 = $ScoreBar/StarFull3/AudioStar3
onready var paula_image = $PaulaSprite
onready var back_button = $BackButton/ButtonLabel
onready var final_score = $FinalScore

onready var selected_phase = Globals.phases_keys[ Globals.actual_phase ]

# PT_BR: Guarda o resultado que o jogador fez
# EN_US: Stores the player result
var result := 0.0

# PT_BR: Armazena o progresso atual da barra de progresso
# EN_US: Stores the actual progress from progress bar
var count = 0.0

# PT_BR: Variáveis para pré-carregar assets de outras pastas
# EN_US: Variables to preload assets from other files
var green_bar = preload("res://assets/Feedbacks/progress_bars/progress_bar_full_green.png")
var yellow_bar = preload("res://assets/Feedbacks/progress_bars/progress_bar_full_yellow.png")
var paula_without_time = preload("res://assets/Feedbacks/paula_time.png")
var paula_bad = preload("res://assets/Feedbacks/paula_bad.png")
var paula_low = preload("res://assets/Feedbacks/paula low.png")
var paula_medium = preload("res://assets/Feedbacks/paula_médio.png")
var paula_execelent = preload("res://assets/Feedbacks/paula_excelente.png")

# PT_BR: Constante de dicionário que armazena as falas de cada feedback
# EN_US: Dictionary constant that has the speechs from all feedbacks
const results_texts: Dictionary = {
	0: 'Você está com dificuldades para identificar o nível de competência, motivação e preparo das pessoas da equipe para delegar tarefas de acordo com essas referências. Sem isso, além de não ter as tarefas executadas adequadamente, pode não estar desenvolvendo o time. :(',
	1: 'Uhu! Você atingiu a meta mínima de acerto na delegação de tarefas de acordo com o nível de competência, motivação e preparo das pessoas. É importante manter sua atenção na qualidade da entrega, perguntas que são feitas, interesse pelo "negócio" da empresa e área de conhecimento de todas as pessoas. Com isso, seus acertos no momento de relacionar pessoas e tarefas vai aumentar e os resultados também!',
	2: 'Yes! Você mostrou-se um líder capaz de identificar o nível de competência, motivação e preparo de várias pessoas da equipe para delegar tarefas de acordo com essas referências! As tarefas da área tendem a ser entregues dentro dos padrões de qualidade esperados e, com isso, você desenvolve o time para que consiga atender demandas cada vez mais complexas.',
	3: 'Parabéns! Seu grau de acerto em identificar o nível de competência, motivação e preparo da equipe para delegar tarefas de acordo com essas referências é excelente! Você está promovendo excelência nas entregas do time, desenvolvendo as habilidades deles. O proximo passo é delegar tarefas que desafiem as competências atuais de forma que as pessoas possam ir além. O nível de motivação de cada pessoa pode ser um bom indicativo.',
	4: 'Que pena! Infelizmente você não conseguiu delegar todas as tarefas a tempo. Tente não acumular tarefas para apenas um funcionário, enquanto existem outros disponíveis. Com isso, sua delegação de tarefas pode se tornar mais eficiente e você poderá obter melhores resultados!',
}

func _ready():
	# PT_BR: Define uma variável "result" como o resultado de uma operação entre os scores da fase
	# EN_US: Defines a variable "result" as the result of a operation between the phase scores
	result = float(Globals.actual_score * 100) / float(Globals.phases_max_score[ selected_phase ])
	
	if Globals.lose_by_time:
		result = 0
	
	if result > Globals.player_phase_score[selected_phase]:
		Globals.player_phase_score[selected_phase] = result
	
	if result < 56:
		back_button.text = "Recomeçar"
	elif result >= 56:
		back_button.text = "Continuar"
	
	# PT_BR: Defina qual texto e sprite irá aparecer de acordo com o valor da variável "result"
	# EN_US: Defines which text and sprite will show according to the value os the variable "result"
	if Globals.lose_by_time:
		result_description.bbcode_text = results_texts[4]
		paula_image.texture = paula_without_time
	elif result < 56 :
		result_description.bbcode_text = results_texts[0]
		paula_image.texture = paula_bad
	elif result < 73:
		result_description.bbcode_text = results_texts[1]
		paula_image.texture = paula_low
	elif result < 85:
		result_description.bbcode_text = results_texts[2]
		paula_image.texture = paula_medium
	else:
		result_description.bbcode_text = results_texts[3]
		paula_image.texture = paula_execelent

func _process(_delta):
	# PT_BR: Muda a cor da barra de progresso de acordo com a variável "count"
	# EN_US: Changes the bar's color accordign to the variable "count"
	if count < 1:
		_change_bar()
		count += 1

# PT_BR: Função que enche as estrelas de acordo com o progresso da barra
# EN_US: Function that fullfil the strars according to the bar's progress
func _change_bar():
	# PT_BR (1): Enquanto "count" foi menor ou igual a "result", 
	# PT_BR (2): A estrela compara o valor de "result" e define o quão será preenchida
	# EN_US (1): While "count" is lower or equal to "result", 
	# EN_US (2): The star compares the value of "result" and defunes how much the will be fullfield
	while count <= result and not Globals.lose_by_time:
		score_bar.value = count
		if 53 < count and count < 55:
			star1.change_value(clamp((result - 53), 0, 3)) 
		if 69 < count and count < 71:
			star2.change_value(clamp((result - 69), 0, 4))
		if 81 < count and count < 83:
			star3.change_value(clamp((result - 81), 0, 4))
		
		final_score.text = ("%00.0f" % count) + "%"
		count += 0.5
		yield(get_tree().create_timer(0.01), "timeout")


# PT_BR: Abre a cena de Fases
# EN_US: Open the phases scene
func _on_BackButton_pressed():
	var path = ""
	if result >= 56:
		path = Globals.bad_end_phase_path[ Globals.actual_phase ]
	else:
		path = Globals.good_end_phase_path[ Globals.actual_phase ]
	
	Globals.actual_score = 0
	var __ = get_tree().change_scene(path)
	

# PT_BR (1): Função conectada a um sinal customizado "StarFull1" que troca a cor da barra e toca um audio.
# PT_BR (2): Parâmetro: texture_progress_node TextureProgress
# EN_US (1): Function connect in a custom signal from "StarFull1" that changes the bar color and plays an audio
# EN_US (2): Parameter: texture_progress_node TextureProgress
func _on_StarFull1_completed_change(_texture_progress_node):
	score_bar.texture_progress = yellow_bar
	audio_star1.playing = true

# PT_BR (1): Função conectada a um sinal customizado "StarFull2" que toca um audio
# PT_BR (2): Parâmetro: texture_progress_node TextureProgress
# EN_US (1): Function connect in a custom signal from "StarFull2" that plays an audio
# EN_US (2): Parameter: texture_progress_node TextureProgress
func _on_StarFull2_completed_change(_texture_progress_node):
	audio_star2.play()


# PT_BR (1): Função conectada a um sinal customizado "StarFull1" que troca a cor da barra e toca um audio
# PT_BR (2): Parâmetro: texture_progress_node TextureProgress
# EN_US (1): Function connect in a custom signal from "StarFull1" that changes the bar color and plays an audio
# EN_US (2): Parameter: texture_progress_node TextureProgress
func _on_StarFull3_completed_change(_texture_progress_node):
	score_bar.texture_progress = green_bar
	audio_star3.play()
