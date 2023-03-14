extends Node2D

# PT_BR: Inicializa variáveis de cenas importantes da fase
# EN_US:
onready var phase_progress = $PhaseProgress
onready var score_label = $ScoreLabel
onready var map = $Map

# PT_BR: Define a variável que armazena a pontuação do jogador
# EN_US:
var score = 0

# PT_BR: Inicializa variáveis responsáveis por armazenar as tarefas atribuídas a cada personagem
# EN_US:
onready var slot_kira = $SlotExpansorKira/SlotCollectionKira/WorkSlotKira
onready var slot_roger = $SlotExpansorRoger/SlotCollectionRoger/WorkSlotRoger
onready var slot_ana = $SlotExpansorAna/SlotCollectionAna/WorkSlotAna
onready var slot_bento = $SlotExpansorBento/SlotCollectionBento/WorkSlotBento


# PT_BR: Função para atualizar a pontuação do jogador
# EN_US:
func _change_score(new_value): 
	score += new_value
	score_label.text = "Score: %0000006d" % score


# PT_BR: Função para mudar a cena quando o tempo do jogo acaba
# EN_US:
func _on_TimeDisplayer_timer_is_over():
	get_tree().change_scene("res://scenes/Defeat.tscn")


# PT_BR: Função para mudar a cena quando o jogador conclui todas as tarefas
# EN_US:
func _on_PhaseProgress_completed_change():
	get_tree().change_scene("res://scenes/Victory.tscn")


# PT_BR: Função para mudar a cena quando o botão de menu é pressionado
# EN_US:
func _on_TextureButton_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")


# PT_BR: Sinal que é emitido quando o personagem finaliza uma tarefa
# PT_BR: Recebe o objeto worker como parâmetro para ser emitido
# PT_BR: Atualiza o progresso da fase, pontuação e retira o item do slot
# EN_US:
func _on_Map_ana_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_ana._clearSlot()
	slot_ana.can_give = true


func _on_Map_bento_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_bento._clearSlot()
	slot_bento.can_give = true


func _on_Map_kira_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_kira._clearSlot()
	slot_kira.can_give = true


func _on_Map_roger_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_roger._clearSlot()
	slot_roger.can_give = true


# PT_BR: Chama a função do mapa para iniciar a tarefa do personagem
# EN_US:
func _on_workSlotKira_get_item(slot):
	slot.can_give = false
	map.Kira_initiate_task(slot)


func _on_workSlotRoger_get_item(slot):
	slot.can_give = false
	map.Roger_initiate_task(slot)


func _on_workSlotBento_get_item(slot):
	slot.can_give = false
	map.Bento_initiate_task(slot)


func _on_workSlotAna_get_item(slot):
	slot.can_give = false
	map.Ana_initiate_task(slot)
