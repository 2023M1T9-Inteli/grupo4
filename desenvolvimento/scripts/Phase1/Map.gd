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


# PT_BR (1): Recebe node do Path2D, node do AnimationPlayer, nome da animação, 
# PT_BR (2): tempo para entregar a tarefa, node do trabalhador e o node da tarefa.
# PT_BR (3): Não retorna nada.		 
# EN_US (1): Receives Path2D node, AnimationPlayer node, animation name,
# EN_US (2): time to delivery the task, worker node and task node.
# EN_US (3): Does not return anything.
func _delivery_task(path: Node, animPath: Node, animName: String, time: float, worker, task):
	$PaulaSprite.hide()
	path.show()
	animPath.play(animName)
	yield(get_tree().create_timer(time), "timeout")
	worker.initiate_task(task)
	yield(get_tree().create_timer(time), "timeout")
	path.hide()
	$PaulaSprite.show()


# PT_BR: Funções para iniciar a entrega de tarefa para cada personagem
# EN_US: Functions to initiate the delivery of the task for each character
func Kira_initiate_task(task):
	_delivery_task($PathKira, 
					$PathKira/PathFollowKira/PaulaAnimKira, 
					"delivery_kira", 
					2.1, 
					kira, 
					task)

func Roger_initiate_task(task):
	_delivery_task($PathRoger,
					$PathRoger/PathFollowRoger/PaulaAnimRoger,
					"delivery_roger",
					0.8,
					roger,
					task)

func Bento_initiate_task(task):
	_delivery_task($PathBento,
					$PathBento/PathFollowBento/PaulaAnimBento,
					"delivery_bento",
					3,
					bento,
					task)

func Ana_initiate_task(task):
	_delivery_task($PathAna,
					$PathAna/PathFollowAna/PaulaAnimAna,
					"delivery_ana",
					3.4,
					ana,
					task)


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
