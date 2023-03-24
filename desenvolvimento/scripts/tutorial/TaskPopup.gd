extends PopupMenu

# PT_BR: Variáveis usadas para fazer a movimentação da animação da ficha do funcionário entre as mesas.
# EN_US:  Variables used to move the worker file animation between tables.
var run_task1 = 0
var run_task2 = 0

# PT_BR (1): Variável que definirá a ordem de execução e exibição dos itens da cena, 
# PT_BR (2): qual texto aparecerá e o que ficará visível ou não.
# EN_US (1): Variable that will define the execution and exhibition order of the scene items,
# EN_US (2): which text will appear and what will be visible or not.
var cont = 0 

# PT_BR: Lista de textos que serão exibidos no Label.
# EN_US: List of texts that will be exhibited in the label.
var text = [
	"""Agora que você já analisou as fichas dos colaboradores, é preciso ler as atividasdes. 
Para isso tente arrastar a pasta da gaveta para a mesa, como no exemplo.""",
	"Perfeito!!\nAgora, com a tarefa expandida, é preciso que você [color=#EE222B]leia[/color] e [color=#3a87ae]interprete[/color] a demanda dela.\nDepois disso, [color=#EE222B]leve[/color] ela a mesa do colaborador",
	"Isso mesmo!!! Depois de entregar a tarefa ao colaborador uma barra de prograsso aparecerá em cima dele, assim que ela for concluída, você já pode distibuir mais uma tarefa para ele(a)",
	"""É preciso ficar atento ao cronômetro no canto superior direito.
Se o tempo acabar, a partida acaba, mesmo que ainda faltem tarefas na gavetar para distribuir.
Organize bem seu tempo.""",
	"c",
	"d"
]

# PT_BR: Variáveis que guardam referências do objeto no tempo de execução.
# EN_US: Variables that store object references at runtime.
onready var clock = $TimeDisplayer
onready var progress = $back_progress
onready var chronometer = $Cronometer


# PT_BR: Função usada para definir a visibilidade do clock, progress e chronometer.
# EN_US: Function that checks the variable cont and decides which text will appear in the scene.
func _ready():
	clock.visible = false
	progress.visible = false
	chronometer.visible = false

# PT_BR: Função que checa a variável cont e decide qual texto aparecerá na cena. 
# EN_US: Function that checks the variable cont and decides which text will appear in the scene.
func _process(delta):
	$text_box/text.bbcode_text = text[cont]
	
	# PT_BR: Variáveis que recebem os pathfollows e têm seus offsets alterados em relação as variáveis run_file1 e run_file2.
	# EN_US: Variables that receive the pathfollows and have their offsets changed in relation to the variables run_file1 and run_file2.
	var path_drawer_table = $Path2D2/path_drawer_table
	path_drawer_table.set_offset(path_drawer_table.get_offset()+run_task1)
	var path_table_worker = $Path2D/path_table_worker
	path_table_worker.set_offset(path_table_worker.get_offset()+run_task2)
	
	if cont == -1:
		get_tree().change_scene("res://scenes/tutorial/File_explanning.tscn")

	elif cont == 0:
		$Path2D/path_table_worker/SmallTask.visible = false
		$Path2D2/path_drawer_table/TaskTeste.visible = true
		$back_task.visible = false
		$back_timer.visible = false
		run_task1 = 2
		run_task2 = 0

	elif cont == 1:
		$Path2D/path_table_worker/SmallTask.visible = true
		$Path2D2/path_drawer_table/TaskTeste.visible = false
		$back_task.visible = true
		chronometer.visible = false
		run_task1 = 0
		run_task2 = 4

	elif cont == 2:
		$Path2D/path_table_worker/SmallTask.visible = false
		chronometer.visible = true
		$back_timer.visible = false
		run_task2 = 0
		chronometer.value += (0.5)
		clock.visible = false
		if chronometer.value == 750:
			chronometer.value = 0
			cont += 1

	elif cont == 3:
		chronometer.visible = false
		clock.visible = true
		progress.visible = false
		
		$SlotExpansorKira/WorkSlotKira.visible = false
		$back_task.visible = false
		
		$BossTable.visible = false
		$back_timer.visible = true
		
	elif cont == 4:
		progress.visible = true
		$back_timer.visible = false
		clock.visible = false
		
	elif cont == 5:
		emit_signal("next_tutorial",self)


# PT_BR (1): Sinal customizado que detecta quando a tarefa é colocada na mesa.
# PT_BR (2): Parâmetro: slot - CenterContainer.
# EN_US (1): Custom signal that detects when the task is dropped on the table.
# EN_US (2): Parameter: slot - CenterContainer.
func _on_testeTarefa02_dropped_item(slot):
	cont += 1

# PT_BR (1): Sinal customizado que detecta quando a ficha é retirada da mesa.
# PT_BR (2): Parâmetro: slot - CenterContainer.
# EN_US (1): Custom signal that detects when the task is taken from the table.
# EN_US (2): Parameter: slot - CenterContainer.
func _on_WorkSlotKira_get_item(slot):
	cont += 1
	
# PT_BR: Sinal customizado que detecta quando o botão de avançar é pressionado.
# EN_US: Custom signal that detects when the next button is pressed.
func _on_next_button_pressed():
	cont += 1

# PT_BR: Sinal customizado que detecta quando o botão de voltar é pressionado.
# EN_US: Custom signal that detects when the back button is pressed.
func _on_back_button_pressed():
	cont -=1 
