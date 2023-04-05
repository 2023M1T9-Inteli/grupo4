extends Node2D

# PT_BR: Pega a cena filha phase_progress
# EN_US: Gets the child scene phase_progress
onready var phase_progress = $PhaseProgress

# PT_BR: Cria variável para a pontuação
# EN_US: Creates variable to the score
var score = 0

# PT_BR: Atributos para simular uma tarefa
# EN_US: Attributes to simulate a task
enum ATTRIBUTES_TYPE {
	 MANUAL_WORK = 2,
	 LOGIC_RAC = 2,
}

# PT_BR: Exporta os atributos para realizar o teste
# EN_US: Export the attributes in a editable form to perform the test
export(Dictionary) var attributes: Dictionary = ATTRIBUTES_TYPE


# PT_BR: Função utilizada para o NPC começar a executar a tarefa
# EN_US: Function used for the NPC to start performing the task
func _on_Button2_pressed():
	$Worker.initiate_task(self)


# PT_BR(1): Sinal personalizado que aumenta a pontuação quando o NPC acabar a tarefa
# PT_BR(2): Parâmetro: worker - mesa do respectivo NPC
# EN_US(1): Custom signal which increases the score when the NPC finishes the task
# EN_US(2): Parameter: worker - desk of the respective NPC
func _on_Worker_finished_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)


# PT_BR(1): Função utilizada para atualizar a pontuação
# PT_BR(2): Parâmetro: new_value - valor da pontuação
# EN_US(1): Funciton used to save and change the score
# EN_US(2): Parameter: new_value - score value
func _change_score(new_value): 
	score += new_value
	$ScoreLabel.text = "Score: %0000006d" % score


# PT_BR: Função que muda para a cena de derrota
# EN_US: Function that switches to the scene of defeat
func _on_TimeDisplayer_timer_is_over():
	get_tree().change_scene("res://scenes/base_phase/Defeat.tscn")


# PT_BR: Sinal personalizado que é enviado quando o progresso da fase chegar ao valor máximo
# EN_US: Custom signal that is sent when stage progress reaches the maximum value  
func _on_PhaseProgress_completed_change():
	# PT_BR: Muda para cena de vitória
	# EN_US: CHanges to Victory Scene
	get_tree().change_scene("res://scenes/base_phase/Victory.tscn")
