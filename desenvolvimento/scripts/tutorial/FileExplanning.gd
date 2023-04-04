extends Node2D

# PT_BR: Inicializa os sinais usados para passar de cena do tutorial
# EN_US: Initializes the signals used to pass the tutorial scene
signal next_tutorial(file)
signal back_tutorial(file)

# PT_BR: Variáveis usadas para fazer a movimentação da animação da ficha do funcionário entre as mesas
# EN_US: Variables used to move the worker file animation between tables
var run_file1 = 0
var run_file2 = 0

# PT_BR (1): Variável que definirá a ordem de execução e exibição dos itens da cena, 
# PT_BR (2): qual texto aparecerá e o que ficará visível ou não
# EN_US (1): Variable that will define the execution and exhibition order of the scene items,
# EN_US (2): which text will appear and what will be visible or not
var cont = 0

# PT_BR: Lista de textos que serão exibidos no label
# EN_US: List of texts that will be exhibited in the label
var text = [
	"""Você deve [color=#EE222B]conhecer o time[/color].
Para isso, tente [color=#3a87ae]arrastar a ficha[/color] que está na mesa de cada colaborador para a mesa de expansão, a fim de analisar as suas habilidades.""" ,
	"""Muito bem!!!
Agora, para [color=#EE222B]devolver[/color] a ficha da pessoa colaboradora em sua respectiva mesa, [color=#3a87ae]basta arrastá-la de volta[/color].""",
	"""Parabéns! Essa etapa do jogo foi concluída!

Clique na seta para [color=#3a87ae]continuar o tutorial[/color].""",
	""
]


func _ready():
	$text_box/back_button.visible = false
	$text_box/next_button.visible = false


# PT_BR: Função que checa a variável cont e decide qual texto aparecerá na cena
# EN_US: Function that checks the variable cont and decides which text will appear in the scene
func _process(_delta):
	# PT_BR: O texto que será exibido no label é o que está dentro da a lista text e muda de acordo com a variável cont
	# EN_US: The text that will be displayed on the label is what is inside the text list and changes according to the variable count
	$text_box/text.bbcode_text = text[cont]
	
	# PT_BR: Variáveis que recebem os pathfollows e têm seus offsets alterados em relação as variáveis run_file1 e run_file2
	# EN_US: Variables that receive the pathfollows and have their offsets changed in relation to the variables run_file1 and run_file2
	var path_worker_table = $path2d_worker_table/pathfollow_worker_table
	path_worker_table.set_offset(path_worker_table.get_offset() + run_file1)
	var path_table_worker = $path2d_table_worker/pathfollow_table_worker
	path_table_worker.set_offset(path_table_worker.get_offset() + run_file2)
	
	if cont == -1:
		emit_signal("back_tutorial",self)
		
	elif cont == 0:
		
		$path2d_worker_table/pathfollow_worker_table/kira_worker.visible = true
		$path2d_table_worker/pathfollow_table_worker/kira_table.visible = false
		run_file1 = 4
		
	elif cont == 1:
		$path2d_table_worker/pathfollow_table_worker/kira_table.visible = true
		$path2d_worker_table/pathfollow_worker_table/kira_worker.visible = false
		run_file1 = 0
		run_file2 = 6
		
	elif cont == 2:
		$text_box/back_button.visible = true
		$text_box/next_button.visible = true
		$path2d_table_worker/pathfollow_table_worker/kira_table.visible = false
		run_file2 = 0
		
	elif cont == 3:
		emit_signal("next_tutorial",self)


# PT_BR (1): Sinal customizado que detecta quando a ficha é solta na mesa de expansão
# PT_BR (2): Parâmetro: _slot - espaço do drag and drop
# EN_US (1): Custom signal that detects when the file is dropped on the expansion table
# EN_US (2): Parameter: _slot - drag and drop space
func _on_Slot_dropped_item(_slot):	
	cont += 1


# PT_BR (1): Sinal customizado que detecta quando a ficha é colocada na mesa do funcionário
# PT_BR (2): Parâmetro: slot - espaço do drag and drop
# EN_US (1): Custom signal that detects when the file is placed on the worker table
# EN_US (2): Parâmetro: slot - drag and drop space
func _on_Slot_get_item(_slot):
	cont += 1


# PT_BR: Sinal customizado que detecta quando o botão de voltar é pressionado
# EN_US: Custom signal that detects when the back button is pressed
func _on_back_button_pressed():
	cont -= 1


# PT_BR: Sinal customizado que detecta quando o botão de avançar é pressionado 
# EN_US: Custom signal that detects when the next button is pressed
func _on_next_button_pressed():
	cont += 1
