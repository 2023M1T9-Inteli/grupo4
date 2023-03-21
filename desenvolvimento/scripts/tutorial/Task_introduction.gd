extends Node2D
signal next_tutorial(task)
signal back_tutorial(task)
var run_task1 = 0
var run_task2 = 0
var cont = 0 
var text = [
	"""Agora, é preciso [color=#EE222B]ler as tarefas[/color].
Para isso, tente arrastar a pasta do arquivo para a mesa de expansão, como demonstra o exemplo.""",
	"""Agora que a tarefa está expandida, é preciso que [color=#EE222B]você interprete as suas demandas[/color].
Após isso, [color=#3a87ae]leve-a para o personagem compatível[/color] com as suas demandas""",
	"""Depois de entregar a tarefa, uma [color=#EE222B]barra de progresso aparecerá[/color] logo acima de quem a recebeu.
Assim que for concluída, você pode [color=#3a87ae]atribuir mais uma tarefa para ele(a)[/color].""",
	"""É preciso ter [color=#EE222B]atenção ao cronômetro da fase[/color]. Se o tempo acabar, [color=#3a87ae]a partida se encerra[/color].""",
	"""Além disso, para você ter o [color=#EE222B]controle do andamento do projeto[/color], acompanhe o [color=#3a87ae]ícone do projeto da fase se preenchendo[/color].""",
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
		emit_signal("back_tutorial")

	elif cont == 0:
		$Path2D/path_table_worker/SmallTask.visible = false
		$Path2D2/path_drawer_table/TaskTeste.visible = true
		$back_task.visible = false
		$back_timer.visible = false
		run_task1 = 6
		run_task2 = 0

	elif cont == 1:
		$Path2D/path_table_worker/SmallTask.visible = true
		$Path2D2/path_drawer_table/TaskTeste.visible = false
		$back_task.visible = true
		chronometer.visible = false
		run_task1 = 0
		run_task2 = 8

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
		emit_signal("next_tutorial")

func _on_testeTarefa02_dropped_item(slot):
	cont += 1
	
func _on_WorkSlotKira_get_item(slot):
	cont += 1
	
func _on_next_button_pressed():
	emit_signal("next_tutorial",self)

func _on_back_button_pressed():
	emit_signal("back_tutorial",self)
