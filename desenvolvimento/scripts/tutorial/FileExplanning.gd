extends Node2D
signal next_tutorial(file)
signal back_tutorial(file)

#PT_BR: Variável que será usada para a movimentação da animação da ficha do funcionário da mesa dela para a mesa de expansão.
var run_file1 = 0
#PT_BR: Variável que será usada para a movimentação da animação da ficha do funcionário da mesa de expansão para a mesa dele de volta.
var run_file2 = 0
#PT_BR: Variável que definirá a ordem de execução e exibição dos itens da cena, ela que define que texto aparecerá como, também, o que ficará visível ou não.
var cont = 0
#PT_BR: Lista de textos que serão exibidos no Lavel.
var text = [
	"""Você deve [color=#EE222B]conhecer o time[/color].
Para isso, tente [color=#3a87ae]arrastar a ficha[/color] que está na mesa de cada colaborador para a mesa de expansão, a fim de analisar as suas habilidades.""" ,
	"""Muito bem!!!
Agora, para [color=#EE222B]devolver[/color] a ficha da pessoa colaboradora em sua respectiva mesa, [color=#3a87ae]basta arrastá-la de volta[/color].""",
	"""Parabéns! Essa etapa do jogo foi concluída!

Clique na seta para [color=#3a87ae]continuar o tutorial[/color].""",
	""
]

#PT_BR: Funcção que servira para ficar checando condicionais do programa enquanto estiver nessa cena.
func _process(_delta):
	#PT_BR: O texto que será exibido no label é o que está dentro da a lista text e muda de acordo com a variável cont
	$text_box/text.bbcode_text = text[cont]
	
	#PT_BR: Essas duas vriáveis elas adotam as identidades dos pathfollows para depois terem seu offset alterados em relação as variáveis run_file1 e run_file2
	var path_worker_table = $path2d_worker_table/pathfollow_worker_table
	path_worker_table.set_offset(path_worker_table.get_offset() + run_file1)
	var path_table_worker = $path2d_table_worker/pathfollow_table_worker
	path_table_worker.set_offset(path_table_worker.get_offset() + run_file2)
	
	#PT_BR: Caso cont seja igual a -1 a cena do jogo é trocada para a cena anterior.
	if cont == -1:
		emit_signal("back_tutorial",self)
		
	#PT_BR: Caso cont seja igual a 0 o ghost da ficha pequena do trabalhador ficará visível, mas o ghost da ficha grande ficará invisível. Além disso, a velocidade de movimentação do pathfollow da ficha pequena torna e ser positiva. 
	elif cont == 0:
		$path2d_worker_table/pathfollow_worker_table/kira_worker.visible = true
		$path2d_table_worker/pathfollow_table_worker/kira_table.visible = false
		run_file1 = 4
		
	#PT_BR: Caso cont seja igual a 1 o ghost da ficha pequena torna a ficarinvisível e o da ficha grande fica visível. A movimentação do pathfollow da ficha pequena 
	elif cont == 1:
		$path2d_table_worker/pathfollow_table_worker/kira_table.visible = true
		$path2d_worker_table/pathfollow_worker_table/kira_worker.visible = false
		run_file1 = 0
		run_file2 = 6
		
	#PT_BR: Caso cont seja igual a 2 o ghost da ficha grande fica invisível e a sua velocaidade fica igual a 0.
	elif cont == 2:
		$path2d_table_worker/pathfollow_table_worker/kira_table.visible = false
		run_file2 = 0
		
	#PT_BR: Mas se cont for 3 a cena do jogo vai ser trocada a a seguinte.
	elif cont == 3:
		emit_signal("next_tutorial",self)
	
#PT_BR: Funcção que detécta quando a ficha pequena é solta na mesa do funcionário, ao acontecer isso conto é acrescentado com + 1
func _on_Slot_dropped_item(_slot):	
	cont += 1

func _on_Slot_get_item(_slot):
	cont += 1

func _on_back_button_pressed():
	cont -= 1

func _on_next_button_pressed():
	cont += 1
