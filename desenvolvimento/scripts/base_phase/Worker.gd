tool
extends Node2D

# PT_BR: Define uma constante para padronizar os atributos que o Worker terá
# EN_US: Define a constant to standardize the attributes that the Worker will have
enum ATTRIBUTES_TYPE {
	 MANUAL_WORK = 3,
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

var score = 0

# PT_BR: Declara o sinal que será emitido quando o Worker terminar a tarefa
# EN_US: Declares the signal that will be emitted when Worker finished the task
signal finished_task(worker)

# PT_BR: Função que iniciará a tarefa. Não retorna valor
# EN_US: Function that initiate task. Doesn't return value
func initiate_task(task):
	# PT_BR: Reseta os valores para iniciar o cronômetro
	# EN_US: Resets the values to start the timer
	cronometer.value = 0
	cronometer.show()
	timer.start()
	_compare_attributes(task["attributes"])


# PT_BR: Compara os atributos da tarefa com os atributos do Worker. Não retorna valor
# EN_US: compares the attributes of a task with the attributes of the Worker. Doesn't return value
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


