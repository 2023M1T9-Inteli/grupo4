# PT_BR: 
# EN_US:
extends Node2D

# PT_BR: Esta é uma definição de enum que atribui valores numéricos para cada membro
# EN_US:this is an enum definition that assigns numerical values to each member
enum ATTRIBUTES_TYPE {
	 MANUAL_WORK = 3,
	 LOGIC_RAC = 0,
	 ART_THINK = 0,
}
# PT_BR: Esta linha define uma variável exportada chamada worker_size, do tipo Vector2.
# EN_US: This line defines an exported variable called worker_size, of type Vector2.
export(Vector2) var worker_size: Vector2 = Vector2(32, 32) setget _set_worker_size

# PT_BR: A função atribui o novo valor à variável  
# EN_US: The function generates a new value for the variable
export(Texture) var worker_image: Texture = null setget _set_worker_image

export(Dictionary) var attributes: Dictionary = ATTRIBUTES_TYPE

func _set_worker_image(new_value) -> void:
	worker_image = new_value
	if weakref($Worker).get_ref():
		$Worker.texture = worker_image

# PT_BR: Define o tamanho mínimo e o tamanho da área retangular do nó chamado  
# EN_US: Defines a minimum size and the size of the rectangular area 
func _set_worker_size(new_value) -> void:
	worker_size = new_value
	$Worker.rect_min_size = worker_size
	$Worker.rect_size = worker_size

# PT_BR: Cria variaveis para o inicio do jogo, onde a pontuacao o tempo e o cronometro estao zerados
# EN_US: Create variables for the beginning of the game, where the score, time and timer are reset
var score = 0
onready var timer = $Timer
onready var cronometer = $Cronometer

# PT_BR: Quando acaba a tarefa sinalisa
# EN_US: When if finish the task it will warn
signal finished_task(worker)

# PT_BR: define o valor do cronômetro como zero, mostra o cronômetro e inicia o temporizador. 
# EN_US: sets the timer value to zero, shows the timer, and starts the timer.
func initiate_task(task):
	_compare_attributes(task["attributes"])
	cronometer.value = 0
	cronometer.show()
	timer.start()

# PT_BR: compara os atributos de uma tarefa com os atributos definidos na variável 'attributes'
# EN_US: compares the attributes of a task with the attributes defined in the attributes variable
func _compare_attributes(task_attributes: Dictionary):
	var comparedAttr = 0
	for key in task_attributes.keys():
		comparedAttr += attributes[key] - task_attributes[key]
	score = 100 + comparedAttr * 10

# PT_BR: Esta função é chamada quando o temporizador chega ao fim
# EN_US:This function is called when the timer expires.
func _on_Timer_timeout():
	if cronometer.value < 100:
		cronometer.value += 1
	else:
		timer.stop()
		cronometer.hide()
		emit_signal("finished_task", self)
