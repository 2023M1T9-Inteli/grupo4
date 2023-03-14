extends Node2D

# PT_BR: Define um sinal para a conclusão de tarefa para cada personagem
# EN_US: Defines a signal for the conclusion of a task for each character
signal kira_fineshed_task(worker)
signal roger_fineshed_task(worker)
signal bento_fineshed_task(worker)
signal ana_fineshed_task(worker)

# PT_BR: Inicializa variáveis e atribui referências de cada personagem
# EN_US:
onready var kira = $Kira
onready var roger = $Roger
onready var bento = $Bento
onready var ana = $Ana

# PT_BR: Funções para emitir o sinal de conclusão de tarefa de cada personagem
# EN_US:
func _on_Kira_finished_task(worker):
	emit_signal("kira_fineshed_task", worker)

func _on_Roger_finished_task(worker):
	emit_signal("roger_fineshed_task", worker)

func _on_Bento_finished_task(worker):
	emit_signal("bento_fineshed_task", worker)

func _on_Ana_finished_task(worker):
	emit_signal("ana_fineshed_task", worker)

# PT_BR: Funções para iniciar a execução de tarefa para cada personagem
# EN_US:
func Kira_initiate_task(task):
	kira.initiate_task(task)

func Roger_initiate_task(task):
	roger.initiate_task(task)

func Bento_initiate_task(task):
	bento.initiate_task(task)

func Ana_initiate_task(task):
	ana.initiate_task(task)
