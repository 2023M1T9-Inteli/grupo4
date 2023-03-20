extends PopupMenu

var run_task1 = 0
var run_task2 = 0
var cont = 0 
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
onready var clock = $TimeDisplayer
onready var progress = $back_progress
onready var chronometer = $Cronometer


func _ready():
	clock.visible = false
	progress.visible = false
	chronometer.visible = false

func _process(delta):
	$text_box/text.bbcode_text = text[cont]
	
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
		

func _on_testeTarefa02_dropped_item(slot):
	cont += 1
	
func _on_WorkSlotKira_get_item(slot):
	cont += 1
	
func _on_next_button_pressed():
	cont += 1

func _on_back_button_pressed():
	cont -=1 
