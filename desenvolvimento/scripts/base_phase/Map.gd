extends Node2D

# PT_BR: Define um sinal para a conclusão de tarefa para cada personagem
# EN_US: Defines a signal for the conclusion of a task for each character
signal kira_fineshed_task(worker)
signal roger_fineshed_task(worker)
signal bento_fineshed_task(worker)
signal ana_fineshed_task(worker)

# PT_BR: Inicializa variáveis e atribui referências de cada personagem
# EN_US: Initialize variables and attribute references from each character
export(NodePath) var kira = null
export(NodePath) var roger = null
export(NodePath) var bento = null
export(NodePath) var ana = null


# PT_BR: Variável para armazenar a lista de informações para entrega de tarefas
# EN_US: Variable to store the list of informations for task delivery
var task_wait_list = []

func _ready():
	kira = _return_object_by_node_path(kira)
	roger = _return_object_by_node_path(roger)
	bento = _return_object_by_node_path(bento)
	ana = _return_object_by_node_path(ana)


# PT_BR (1): Função para retornar um objeto a partir do seu node path
# PT_BR (2): Parâmetro: node_path - NodePath
# EN_US (1): Function to return an object from its node path
# EN_US (2): Parameter:  node_path - NodePath
func _return_object_by_node_path(node_path):
	if node_path != null and not node_path.is_empty():
		return self.get_node(node_path)
	return null

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
	if len(task_wait_list) == 1:
		_check_task_wait_list()
		
		
# PT_BR (1): Função para receber as informações das tarefas do personagem "Kira"
# PT_BR (2): E chamar a função para armazenar na lista de espera
# EN_US (1): Function to receives the task informations from the character "Kira"
# EN_US (2): And call the function to put in the wait list
func Kira_initiate_task(task):
	var task_info = {
		"path": $PathKira,
		"anim_path": $PathKira/PathFollowKira/PaulaAnimKira, 
		"anim_name": "delivery_kira", 
		"time": 2.1, 
		"worker": kira, 
		"task_node": task,
	}
	_receive_task_order(task_info)

# PT_BR (1): Função para receber as informações das tarefas do personagem "Roger"
# PT_BR (2): E chamar a função para armazenar na lista de espera
# EN_US (1): Function to receives the task informations from the character "Roger"
# EN_US (2): And call the function to put in the wait list
func Roger_initiate_task(task):
	var task_info = {
		"path": $PathRoger, 
		"anim_path": $PathRoger/PathFollowRoger/PaulaAnimRoger, 
		"anim_name": "delivery_roger", 
		"time": 0.8, 
		"worker": roger, 
		"task_node": task,
	}
	_receive_task_order(task_info)

# PT_BR (1): Função para receber as informações das tarefas do personagem "Bento"
# PT_BR (2): E chamar a função para armazenar na lista de espera
# EN_US (1): Function to receives the task informations from the character "Bento"
# EN_US (2): And call the function to put in the wait list
func Bento_initiate_task(task):
	var task_info = {
		"path": $PathBento, 
		"anim_path": $PathBento/PathFollowBento/PaulaAnimBento, 
		"anim_name": "delivery_bento", 
		"time": 3, 
		"worker": bento, 
		"task_node": task,
	}
	_receive_task_order(task_info)

# PT_BR (1): Função para receber as informações das tarefas do personagem "Ana"
# PT_BR (2): E chamar a função para armazenar na lista de espera
# EN_US (1): Function to receives the task informations from the character "Ana"
# EN_US (2): And call the function to put in the wait list
func Ana_initiate_task(task):
	var task_info = {
		"path": $PathAna, 
		"anim_path": $PathAna/PathFollowAna/PaulaAnimAna, 
		"anim_name": "delivery_ana", 
		"time": 3.4, 
		"worker": ana, 
		"task_node": task,
	}
	_receive_task_order(task_info)


# PT_BR: Função para emitir o sinal de conclusão de tarefa do personagem "Kira"
# EN_US: Function to emit the task conclusion signal from the character "Kira"
func _on_Kira_finished_task(worker):
	emit_signal("kira_fineshed_task", worker)

# PT_BR: Função para emitir o sinal de conclusão de tarefa do personagem "Roger"
# EN_US: Function to emit the task conclusion signal from the character "Roger"
func _on_Roger_finished_task(worker):
	emit_signal("roger_fineshed_task", worker)

# PT_BR: Função para emitir o sinal de conclusão de tarefa do personagem "Bento"
# EN_US: Function to emit the task conclusion signal from the character "Bento"
func _on_Bento_finished_task(worker):
	emit_signal("bento_fineshed_task", worker)

# PT_BR: Função para emitir o sinal de conclusão de tarefa do personagem "Ana"
# EN_US: Function to emit the task conclusion signal from the character "Ana"
func _on_Ana_finished_task(worker):
	emit_signal("ana_fineshed_task", worker)
