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


func _on_Button2_pressed():
	# PT_BR: Ao clicar no botão o npc vai começar a tarefa
	# EN_US: When you click the button the npc will start the task
	$Worker.initiate_task(self)


# PT_BR: Sinal que aumenta a pontuação quando o npc acabar a tarefa
# EN_US: Signal which increases the score when the npc finishes the task
func _on_Worker_finished_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)

# PT_BR: Função utilizada para atualizar a pontuação. Não retorna valor.
# EN_US: Funciton used to save and change the score. Doesn't return value.
func _change_score(new_value): 
	score += new_value
	$ScoreLabel.text = "Score: %0000006d" % score

func _on_TimeDisplayer_timer_is_over():
	# PT_BR: Muda para cena de derrota
	# EN_US: CHanges to Defeat Scene
	get_tree().change_scene("res://scenes/base_phase/Defeat.tscn")

# PT_BR: Sinal personalizado que é enviado quando o progresso da fase chegar ao valor máximo
# EN_US: Custom signal that is sent when stage progress reaches the maximum value  
func _on_PhaseProgress_completed_change():
	# PT_BR: Muda para cena de vitória
	# EN_US: CHanges to Victory Scene
	get_tree().change_scene("res://scenes/base_phase/Victory.tscn")
