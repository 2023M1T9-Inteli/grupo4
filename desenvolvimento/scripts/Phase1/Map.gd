extends Node2D

# PT_BR: Define um sinal para a conclusão de tarefa para cada personagem
# EN_US: Defines a signal for the conclusion of a task for each character
signal kira_fineshed_task(worker)
signal roger_fineshed_task(worker)
signal bento_fineshed_task(worker)
signal ana_fineshed_task(worker)

# PT_BR: Inicializa variáveis e atribui referências de cada personagem
# EN_US: Initialize variables and attribute references from each character
onready var kira = $Kira
onready var roger = $Roger
onready var bento = $Bento
onready var ana = $Ana

# PT_BR: Variável para armazenar a lista de informações para entrega de tarefas
# EN_US: Variable to store the list of informations for task delivery
var task_wait_list = []


# PT_BR (1): Recebe node do Path2D, node do AnimationPlayer, nome da animação, 
# PT_BR (2): tempo para entregar a tarefa, node do trabalhador e o node da tarefa
# PT_BR (3): Não retorna nada 
# EN_US (1): Receives Path2D node, AnimationPlayer node, animation name,
# EN_US (2): time to delivery the task, worker node and task node
# EN_US (3): Does not return anything
func _delivery_task(path: Node, anim_path: Node, anim_name: String, time: float, worker, task):
	$PaulaSprite.hide()
	path.show()
	anim_path.play(anim_name)
	yield(get_tree().create_timer(time), "timeout")
	worker.initiate_task(task)
	yield(get_tree().create_timer(time), "timeout")
	path.hide()
	$PaulaSprite.show()
	
	
# PT_BR: Função para checar a lista de espera e entregar as tarefas
# EN_US: Function to check the list and delivery the tasks
func _check_task_wait_list():	
	if len(task_wait_list) > 0:
		var task = task_wait_list[0]
		_delivery_task(task.path, task.anim_path, task.anim_name, task.time, task.worker, task.task_node)
		yield(get_tree().create_timer(task.time * 2 + 0.1), "timeout")
		task_wait_list.pop_front()
		_check_task_wait_list()
		
		
# PT_BR: Recebe as informações da tarefa e não retorna nada
# EN_US: Receives the task informations and does not return anything
func _receive_task_order(task_info):
# PT_BR (1): Armazena as informações da tarefa na lista de espera
# PT_BR (2): Chama a função para checar a lista de espera
# EN_US (1): Store the task informations in the wait list
# EN_US (2): Call the function to check the wait list
	task_wait_list.append(task_info)
	print(task_wait_list)
	if len(task_wait_list) == 1:
		_check_task_wait_list()
		
		
# PT_BR: Funções para receberem as informações das tarefas de cada funcionário e chamar a função para armazenar na lista de espera
# EN_US: Functions to receive the task informations from each character and call the function to put in the wait list
func Kira_initiate_task(task):
	var task_info = {
		"path": $PathKira,
		"anim_path": $PathKira/PathFollowKira/PaulaAnimKira, 
		"anim_name": "delivery_kira", 
		"time": 2.1, 
		"worker": kira, 
		"task_node": task
	}
	_receive_task_order(task_info)


func Roger_initiate_task(task):
	var task_info = {
		"path": $PathRoger, 
		"anim_path": $PathRoger/PathFollowRoger/PaulaAnimRoger, 
		"anim_name": "delivery_roger", 
		"time": 0.8, 
		"worker": roger, 
		"task_node": task
	}
	_receive_task_order(task_info)
	
func Bento_initiate_task(task):
	var task_info = {
		"path": $PathBento, 
		"anim_path": $PathBento/PathFollowBento/PaulaAnimBento, 
		"anim_name": "delivery_bento", 
		"time": 3, 
		"worker": bento, 
		"task_node": task
	}
	_receive_task_order(task_info)

func Ana_initiate_task(task):
	var task_info = {
		"path": $PathAna, 
		"anim_path": $PathAna/PathFollowAna/PaulaAnimAna, 
		"anim_name": "delivery_ana", 
		"time": 3.4, 
		"worker": ana, 
		"task_node": task
	}
	_receive_task_order(task_info)


# PT_BR: Funções para emitir o sinal de conclusão de tarefa de cada personagem
# EN_US: Functions to emit each character's task conclusion signal
func _on_Kira_finished_task(worker):
	emit_signal("kira_fineshed_task", worker)

func _on_Roger_finished_task(worker):
	emit_signal("roger_fineshed_task", worker)

func _on_Bento_finished_task(worker):
	emit_signal("bento_fineshed_task", worker)

func _on_Ana_finished_task(worker):
	emit_signal("ana_fineshed_task", worker)
