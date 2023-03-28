extends Node2D

# PT_BR: Exporta a variável para selecionar a fase
# EN_US: Exports the variable for select the phase
export(Globals.PHASES) var phase_key = Globals.PHASES.PHASE_1

# PT_BR: Inicializa variáveis de cenas importantes da fase
# EN_US: Initialize variables of important scenes of the phase
export(NodePath) onready var phase_progress = $PhaseProgress
export(NodePath) onready var map = $Map

# PT_BR: Inicializa variáveis responsáveis por armazenar os slots das tarefas de cada personagem
# EN_US: Initialize variables responsible for storing the tasks slots of each character
export(NodePath) onready var slot_kira = $Slots/SlotExpansorKira/SlotCollectionKira/WorkSlotKira
export(NodePath) onready var slot_roger = $Slots/SlotExpansorRoger/SlotCollectionRoger/WorkSlotRoger
export(NodePath) onready var slot_ana = $Slots/SlotExpansorAna/SlotCollectionAna/WorkSlotAna
export(NodePath) onready var slot_bento = $Slots/SlotExpansorBento/SlotCollectionBento/WorkSlotBento

# PT_BR: Inicializa variáveis responsáveis por armazenar os slots das fichas de perfil de cada personagem
# EN_US: Initialize variables responsible for storing the profile sheets slots of each character
export(NodePath) onready var profile_kira = $Slots/SlotExpansorKira/SlotCollectionKira/ProfileSlotKira
export(NodePath) onready var profile_roger = $Slots/SlotExpansorRoger/SlotCollectionRoger/ProfileSlotRoger
export(NodePath) onready var profile_ana = $Slots/SlotExpansorAna/SlotCollectionAna/ProfileSlotAna
export(NodePath) onready var profile_bento = $Slots/SlotExpansorBento/SlotCollectionBento/ProfileSlotBento

# PT_BR: Inicializa variáveis que armazenam os as estrelas da pontuação
# EN_US: Initialize variables that stores the progress stars
export(NodePath) onready var star1 = $Scores/StarProgress1
export(NodePath) onready var star2 = $Scores/StarProgress2
export(NodePath) onready var star3 = $Scores/StarProgress3

# PT_BR: Armazena a referência do objeto ClickAudio
# EN_US: Stores the ClickAudio object reference
onready var click_audio = $ClickAudio

# PT_BR: Armazena a referência do objeto ClickAudio
# EN_US: Stores the ClickAudio object reference
onready var pause_scene = $Pause

# PT_BR: Armazena o score máximo da fase
# EN_US: Stores the phase max score
onready var max_score = Globals.phases_max_score[ Globals.phases_keys[phase_key] ]


# PT_BR: Reseta a variável de pontos.
# EN_US: Reset the points variable.
func _ready():
	Globals.set_actual_score(0)
	Globals.set_actual_phase(phase_key)


#PR_BR: Essa função observa a posição do mouse e aplica o hover nas fichas
#EN_US: This funcction observes the mouse position and applies the hover on the files 
func _process(_delta):
	# PT_BR: As variáveis baixo armazenam o nó que será usado na função
	# EN_US: The variables below stores a node which will be used by the function
	_send_hover_effect_in_file(profile_kira)
	_send_hover_effect_in_file(profile_roger)
	_send_hover_effect_in_file(profile_ana)
	_send_hover_effect_in_file(profile_bento)


# PT_BR: Função para atualizar a pontuação do jogador
# EN_US: Function to update the player's score
func _change_score(new_value): 
	Globals.set_actual_score(Globals.actual_score + new_value)
	var actual_score = Globals.actual_score
	var result := float(actual_score * 100) / float(max_score)

	if result > 73:
		star3.value = clamp((result - 73), 0, 12)
		star2.value = clamp((result - 56), 0, 17)
	elif result > 56: 
		star2.value = clamp((result - 56), 0, 17)
		star1.value = clamp(result, 0, 56)
		
	star1.value = clamp(result, 0, 56)


# PT_BR: Função para mudar a cena quando o tempo do jogo acaba
# EN_US: Function to change the scene when the game time is over
func _on_TimeDisplayer_timer_is_over():
	Globals.lose_by_time = true
	var __ = get_tree().change_scene("res://scenes/Result/Result.tscn")


# PT_BR: Função para mudar a cena quando o jogador conclui todas as tarefas
# EN_US: Function to change the scene when the player concludes all tasks
func _on_PhaseProgress_completed_change():
	var __ = get_tree().change_scene("res://scenes/Result/Result.tscn")


# PT_BR (1): Sinal que é emitido quando o personagem "Ana" finaliza uma tarefa
# PT_BR (2): Recebe o objeto worker como parâmetro para ser emitido
# PT_BR (3): Atualiza o progresso da fase, pontuação e retira o item do slot
# EN_US (1): Signal that is sent when the character "Ana" ends a task
# EN_US (2): Receives the worker object as parameter to be sent
# EN_US (3): Updates the phase progress, score and removes the item from slot
func _on_Map_ana_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_ana._clearSlot()
	slot_ana.can_give = true


# PT_BR (1): Sinal que é emitido quando o personagem "Bento" finaliza uma tarefa
# PT_BR (2): Recebe o objeto worker como parâmetro para ser emitido
# PT_BR (3): Atualiza o progresso da fase, pontuação e retira o item do slot
# EN_US (1): Signal that is sent when the character "Bento" ends a task
# EN_US (2): Receives the worker object as parameter to be sent
# EN_US (3): Updates the phase progress, score and removes the item from slot
func _on_Map_bento_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_bento._clearSlot()
	slot_bento.can_give = true


# PT_BR (1): Sinal que é emitido quando o personagem "Kira" finaliza uma tarefa
# PT_BR (2): Recebe o objeto worker como parâmetro para ser emitido
# PT_BR (3): Atualiza o progresso da fase, pontuação e retira o item do slot
# EN_US (1): Signal that is sent when the character "Kira" ends a task
# EN_US (2): Receives the worker object as parameter to be sent
# EN_US (3): Updates the phase progress, score and removes the item from slot
func _on_Map_kira_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_kira._clearSlot()
	slot_kira.can_give = true


# PT_BR (1): Sinal que é emitido quando o personagem "Roger" finaliza uma tarefa
# PT_BR (2): Recebe o objeto worker como parâmetro para ser emitido
# PT_BR (3): Atualiza o progresso da fase, pontuação e retira o item do slot
# EN_US (1): Signal that is sent when the character "Roger" ends a task
# EN_US (2): Receives the worker object as parameter to be sent
# EN_US (3): Updates the phase progress, score and removes the item from slot
func _on_Map_roger_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_roger._clearSlot()
	slot_roger.can_give = true


# PT_BR: Chama a função do mapa para iniciar a tarefa do personagem "Kira"
# EN_US: Calls the map function to iniciate the character's "Kira" task
func _on_WorkSlotKira_get_item(slot):
	slot.can_give = false
	map.Kira_initiate_task(slot)


# PT_BR: Chama a função do mapa para iniciar a tarefa do personagem "Roger"
# EN_US: Calls the map function to iniciate the character's "Roger" task
func _on_WorkSlotRoger_get_item(slot):
	slot.can_give = false
	map.Roger_initiate_task(slot)


# PT_BR: Chama a função do mapa para iniciar a tarefa do personagem "Bento"
# EN_US: Calls the map function to iniciate the character's "Bento" task
func _on_WorkSlotBento_get_item(slot):
	slot.can_give = false
	map.Bento_initiate_task(slot)


# PT_BR: Chama a função do mapa para iniciar a tarefa do personagem "Ana"
# EN_US: Calls the map function to iniciate the character's "Ana" task
func _on_WorkSlotAna_get_item(slot):
	slot.can_give = false
	map.Ana_initiate_task(slot)


# PT_BR: Dá o comando de emitir o som assim que o mouse é pressionado.
# EN_US: Gives the command to emit the sound when the mouse is pressed.
func _input(event):
	if event.is_action_pressed("click"):
		click_audio.play()


# PT_BR (1): Essa função aplica o hover nas fichas
# PT_BR (2): Recebe: begin, que é o limite inferior da zona de entrada do mouse: Vector2
# PT_BR (3): Recebe: end, que é o limite superior da zona de entrada do mouse: Vector2
# PT_BR (4): Recebe: slot, que é um nó da cena
# EN_US (1): This function applies the hover to the files
# EN_US (2): Receive: begin, which is the lower limit of the mouse input zone: Vector2
# EN_US (3): Receive: end, which is the higher limit of the mouse input zone: Vector2
# EN_US (4): Receive: slot, which is a node in the scene
func _hover_file(begin: Vector2, end: Vector2, slot:CenterContainer):
	var mouse = get_global_mouse_position()
	
	if mouse.x >= begin.x and mouse.x <= end.x and mouse.y >= begin.y and mouse.y <= end.y:
		slot.rect_scale  = Vector2(1.25,1.25)
	else:
		slot.rect_scale = Vector2(1,1)


# PT_BR (1): Essa função simplifica a chamada da função hover file
# PT_BR (2): Recebe o perfil: Center Container
# EN_US (1): This function simplifies calling the hover file function
# EN_US (2): Receives the profile: Center Container
func _send_hover_effect_in_file(profile):
	var begin = profile.rect_global_position
	var end = begin + profile.rect_size
	
	_hover_file(begin, end, profile)


func _on_Pause_button_pressed():
	pause_scene.open_pause_scene()
