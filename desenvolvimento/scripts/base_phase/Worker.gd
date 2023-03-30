tool
extends Node2D

# PT_BR: Define uma constante para padronizar os atributos que o Worker terá
# EN_US: Define a constant to standardize the attributes that the Worker will have
enum ATTRIBUTES_TYPE {
	 MANUAL_WORK = 0,
	 LOGIC_RAC = 0,
	 ART_THINK = 0,
}

# PT_BR: Exporta a variável para definir o tamanho
# EN_US: Export the variable to define the size
export(Vector2) var worker_size: Vector2 = Vector2(32, 32) setget _set_worker_size

# PT_BR: Exporta a variável para definir a imagem
# EN_US: Export the variable to define the image
export(Texture) var worker_image: Texture = null setget _set_worker_image

# PT_BR: Exporta a variável para definir os atributos
# EN_US: Export the variable to define the attributes
export(Dictionary) var attributes: Dictionary = ATTRIBUTES_TYPE

# PT_BR: Funções para definir as variáveis
# EN_US: Functions to set variables
func _set_worker_image(new_value) -> void:
	worker_image = new_value
	if weakref($Worker).get_ref():
		$Worker.texture = worker_image


# PT_BR: Define o tamanho de cada colaborador(a) no jogo
# EN_US: Sets the size of each worker in the game.
func _set_worker_size(new_value) -> void:
	worker_size = new_value
	$Worker.rect_min_size = worker_size
	$Worker.rect_size = worker_size
	if weakref($Collision).get_ref():
		$Collision.shape.extents.x = worker_size.x / 2
		$Collision.shape.extents.y = worker_size.y / 2
		$Collision.position.x = worker_size.x / 2
		$Collision.position.y = worker_size.y / 2

# PT_BR: Armazena o objeto Timer
# EN_US: Stores the Timer object
onready var timer = $Timer

# PT_BR: Armazena o objeto Cronometer
# EN_US: Stores the Cronometer object
onready var cronometer = $Cronometer

# PT_BR: Armazena o objeto FinishedTask
# EN_US: Stores the FinishedTask object
onready var audio_finished_task = $FinishedTask

# PT_BR: Armazena a pontuação
# EN_US: Stores the score
var score = 0

# PT_BR(1): Declara o sinal que será emitido quando o NPC terminar a tarefa
# PT_BR(2): Parâmetro: worker - mesa do NPC
# EN_US(1): Declares the signal that will be emitted when NPC finished the task
# EN_US(2): Parameter: worker - NPC table
signal finished_task(worker)


# PT_BR(1): Função que iniciará a tarefa
# PT_BR(2): Parâmetro: task - tarefa que será iniciada
# EN_US(1): Function that initiate task
# EN_US(2): Parameter: task - task that will be started
func initiate_task(task):
	# PT_BR: Reseta os valores para iniciar o cronômetro
	# EN_US: Resets the values to start the timer
	cronometer.value = 0
	cronometer.show()
	self.score = 0
	timer.start()
	_compare_attributes(task["attributes"])


# PT_BR(1): Compara os atributos da tarefa com os atributos do Worker
# PT_BR(2): Parâmetro: task_attributes - atributo da tarefa
# EN_US(1): Compares the attributes of a task with the attributes of the Worker
# EN_US(2): Parameter: task_attributes - task attribute
func _compare_attributes(task_attributes: Dictionary):
	var comparedAttr = 0
	for key in task_attributes.keys():
		comparedAttr += attributes[key] - task_attributes[key]

	# PT_BR: Atualiza a pontuação com a diferença entre os atributos do worker e os da tarefa
	# EN_US: Updates the score with the difference between worker and task attributes
	score = 100 + comparedAttr * 50


func _on_Timer_timeout():
	# PT_BR: Se o valor do cronômetro é menor que 100
	# EN_US: If the cronometer value is less than 100
	if cronometer.value < 100:
		
		# PT_BR: Incrementa o valor do cronômetro com mais 1
		# EN_US: Increments the timer value by 1 more
		cronometer.value += 1
	else:
		# PT_BR: Reseta o valor do timer, esconde o cronômetro, toca o som e emite o sinal da task finalizada.
		# EN_US: Resets the timer value, hides the stopwatch, play the sound and emits the finished task signal.
		timer.stop()
		cronometer.hide()
		audio_finished_task.play()
		emit_signal("finished_task", self)


