extends Node2D
# PT_BR: Cria variavel para a pontuacao 
# EN_US: Creates variable to the ponctuation
onready var phase_progress = $PhaseProgress
var score = 0

# PT_BR: Atributos para guardar uma tarefa
#EN_US: Attributes to save one task
enum ATTRIBUTES_TYPE {
	 MANUAL_WORK = 2,
	 LOGIC_RAC = 2,
}

# PT_BR: Variaveis exportadas de forma editavel para realizar teste
# EN_US: Exported variables in a editable form to perform test
export(Dictionary) var attributes: Dictionary = ATTRIBUTES_TYPE


func _on_Button2_pressed():
	# PT_BR: Ao clicar o botao o npc vai comecar a tarefa
	# EN_US: When you click the button the npc will start the tas
	$Worker.initiate_task(self)

# PT_BR: Funcao para quando o npc acabar a tarefa e tambem almenta a pontuacao
# EN_US: Function for when the npc finishes the task and also increases the score 
func _on_Worker_finished_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)

# PT_BR: Funcao ultilizada para guardar e trocar a pontuacao 
# EN_US: Funciton used to save and change the score
func _change_score(new_value): 
	score += new_value
	$ScoreLabel.text = "Score: %0000006d" % score

# PT_BR: Essa funcao mostra quando o tempo para completar a tarefa esgotar 
# EN_US: This function shows when the time to complete the task runs out.
func _on_TimeDisplayer_timer_is_over():
	get_tree().change_scene("res://scenes/base_phase/Defeat.tscn")

# PT_BR: Essa funcao mostra quando a tarefa for concluida
# EN_US: This funciton shows when the task is concluded
func _on_PhaseProgress_completed_change():
	get_tree().change_scene("res://scenes/base_phase/Victory.tscn")
