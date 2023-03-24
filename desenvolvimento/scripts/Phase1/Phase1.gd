extends Node2D

# PT_BR: Inicializa variáveis de cenas importantes da fase
# EN_US: Initialize variables of important scenes of the phase
onready var phase_progress = $PhaseProgress
onready var map = $Map

# PT_BR: Inicializa variáveis responsáveis por armazenar as tarefas atribuídas a cada personagem
# EN_US: Initialize variables responsible for storing the tasks attributed to each character
onready var slot_kira = $Slots/SlotExpansorKira/SlotCollectionKira/WorkSlotKira
onready var slot_roger = $Slots/SlotExpansorRoger/SlotCollectionRoger/WorkSlotRoger
onready var slot_ana = $Slots/SlotExpansorAna/SlotCollectionAna/WorkSlotAna
onready var slot_bento = $Slots/SlotExpansorBento/SlotCollectionBento/WorkSlotBento


#PT_BR: Importa o som de pause.
# EN_US:
var paused_sound = preload("res://assets/Audio/Pause.wav")


#PR_BR: Essa função observa a posição do mouse e aplica o hover nas fichas
#EN_US: This funcction observes the mouse position and applies the hover on the files 
func _process(delta):
	# PT_BR: As variáveis baixo armazenam o nó que será usado na função
	# EN_US: The variables below stores a node which will be used by the function
	var profile_kira = $Slots/SlotExpansorKira/SlotCollectionKira/ProfileSlotKira
	hover_file(184,232,344,392,profile_kira)

	var profile_roger = $Slots/SlotExpansorRoger/SlotCollectionRoger/ProfileSlotRoger
	hover_file(584,632,344,392,profile_roger)

	var profile_ana = $Slots/SlotExpansorAna/SlotCollectionAna/ProfileSlotAna
	hover_file(184,232,536,584,profile_ana)
	
	var profile_bento = $Slots/SlotExpansorBento/SlotCollectionBento/ProfileSlotBento
	hover_file(584,632,536,584,profile_bento)

# PT_BR: Função para atualizar a pontuação do jogador
# EN_US: Function to update the player's score
func _change_score(new_value): 
	Globals.score_phase_1 += new_value
	var result := float(Globals.score_phase_1 * 100) / float(Globals.max_score_phase_1)

	if result > 73:
		$Scores/StarProgress3.value = clamp((result - 73), 0, 12)
		$Scores/StarProgress2.value = clamp((result - 56), 0, 17)
	elif result > 56: 
		$Scores/StarProgress2.value = clamp((result - 56), 0, 17)
		$Scores/StarProgress1.value = clamp(result, 0, 56)
		
	$Scores/StarProgress1.value = clamp(result, 0, 56)


# PT_BR: Função para mudar a cena quando o tempo do jogo acaba
# EN_US: Function to change the scene when the game time is over
func _on_TimeDisplayer_timer_is_over():
	var __ = get_tree().change_scene("res://scenes/Result/Defeat.tscn")


# PT_BR: Função para mudar a cena quando o jogador conclui todas as tarefas
# EN_US: Function to change the scene when the player concludes all tasks
func _on_PhaseProgress_completed_change():
	var __ = get_tree().change_scene("res://scenes/Result/Result.tscn")


# PT_BR (1): Sinal que é emitido quando o personagem finaliza uma tarefa
# PT_BR (2): Recebe o objeto worker como parâmetro para ser emitido
# PT_BR (3): Atualiza o progresso da fase, pontuação e retira o item do slot
# EN_US (1): Signal that is sent when the character ends a task
# EN_US (2): Receives the worker object as parameter to be sent
# EN_US (3): Updates the phase progress, score and removes the item from slot
func _on_Map_ana_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_ana._clearSlot()
	slot_ana.can_give = true
	$Conclued_task.play()


func _on_Map_bento_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_bento._clearSlot()
	slot_bento.can_give = true
	$Conclued_task.play()


func _on_Map_kira_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_kira._clearSlot()
	slot_kira.can_give = true
	$Conclued_task.play()


func _on_Map_roger_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_roger._clearSlot()
	slot_roger.can_give = true
	$Conclued_task.play()


# PT_BR: Chama a função do mapa para iniciar a tarefa do personagem
# EN_US: Calls the map function to iniciate the character's task
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

#PT_BR: Essa função servirá para dar o comando de emitir o som assim que o mouse é pressionado.
# EN_US:
func _input(event):
	if event.is_action_pressed("click"):
		$Click_sound.play()


# PT_BR: Resetar a variável de pontos
# EN_US:
func _ready():
	Globals.score_phase_1 = 0
	

# PT_BR: Põem o som de pause
# EN_US:
func _on_Pause_button_pressed():
	Audio.change_music(paused_sound)


# PT_BR(1): Essa função aplica o hover nas fichas
# PT_BR(2): Recebe: x1, que é o limite inferior em x da zona de entrada do mouse
# PT_BR(3): Recebe: x2, que é o limite superior em x da zona de entrada do mouse
# PT_BR(4): Recebe: y1, que é o limite inferior em y da zona de entrada do mouse
# PT_BR(5): Recebe: y2, que é o limite superior em x da zona de entrada do mouse
# PT_BR(6): Recebe: slot, que é um nó da cena

# EN_US(1): This function applies the hover to the files
# EN_US(2): Receive: x1, wich is the lower limit on x of the mouse input zone
# EN_US(3): Receive: x2, wich is the upper limit on x of the mouse input zone
# EN_US(4): Receive: y1, wich is the lower limit on y of the mouse input zone
# EN_US(5): Receive: y2, wich is the upper limit on y of the mouse input zone
# EN_US(6): Receive: slot, wich is a node in the scene
func hover_file(x1,x2,y1,y2,slot:CenterContainer):
	var mouse = get_global_mouse_position()
	if mouse.x >= x1 and mouse.x <= x2 and mouse.y >= y1 and mouse.y <= y2:
		slot.rect_scale  = Vector2(1.25,1.25)
	else:
		slot.rect_scale = Vector2(1,1)

