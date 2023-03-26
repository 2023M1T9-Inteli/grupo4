extends PopupMenu

# PT_BR (1): Variável que definirá a ordem de execução e exibição dos itens da cena, 
# PT_BR (2): qual texto aparecerá e o que ficará visível ou não.
# EN_US (1): Variable that will define the execution and exhibition order of the scene items,
# EN_US (2): which text will appear and what will be visible or not.
var cont = 0

# PT_BR: Lista de textos que serão exibidos no Label.
# EN_US: List of texts that will be exhibited in the label.
var textos: Array = [
	
	"""Olá! 
Seja bem vindo ao tutorial do jogo [color=#ee222b]O Talento de Delegar.[/color]

Para avançarmos [color=#EE222B]aperte[/color] na [color=#3a87ae]seta[/color].""",

""

]

# PT_BR: Função que checa a variável cont e decide qual texto aparecerá na cena.
# EN_US: Function that checks the variable cont and decides which text will appear in the scene.
func _process(delta):
	
	if cont == -1:
		get_tree().change_scene("res://scenes/Menu.tscn")
	
	elif cont == 1:
		get_tree().change_scene("res://scenes/tutorial/Skip_button_explanning.tscn")
	
	$text_box/introduction_text.bbcode_text = textos[cont]
	

# PT_BR: Sinal customizado que detecta quando o botão de avançar é pressionado.
# EN_US: Custom signal that detects when the next button is pressed.
func _on_next_button_pressed():
	cont += 1

# PT_BR: Sinal customizado que detecta quando o botão de voltar é pressionado.
# EN_US: Custom signal that detects when the back button is pressed.
func _on_back_button_pressed():
	cont -= 1
