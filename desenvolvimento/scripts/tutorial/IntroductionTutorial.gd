extends Node2D

# PT_BR: Inicializa os sinais usados para passar de cena do tutorial.
# EN_US:Initializes the signals used to pass the tutorial scene.
signal next_tutorial()
signal back_tutorial()

# PT_BR (1): Variável que definirá a ordem de execução e exibição dos itens da cena, 
# PT_BR (2): qual texto aparecerá e o que ficará visível ou não.
# EN_US (1): Variable that will define the execution and exhibition order of the scene items,
# EN_US (2): which text will appear and what will be visible or not.
var cont = 0

# PT_BR: Lista de textos que serão exibidos no Label.
# EN_US: List of texts that will be exhibited in the label.
var textos: Array = [
	
	"""Olá! Seja bem-vindo(a) ao tutorial do jogo O Talento de Delegar.

Para avançar ou voltar, clique nas [color=#3a87ae]setas[/color] abaixo.""",

""

]


# PT_BR: Função que checa a variável cont e decide qual texto aparecerá na cena.
# EN_US: Function that checks the variable cont and decides which text will appear in the scene.
func _process(_delta):
	if cont == -1:
		emit_signal("back_tutorial")
	
	elif cont == 1:
		emit_signal("next_tutorial")
	
	$text_box/introduction_text.bbcode_text = textos[cont]
	


# PT_BR: Sinal customizado que detecta quando o botão de avançar é pressionado.
# EN_US: Custom signal that detects when the next button is pressed.
func _on_next_button_pressed():
	emit_signal("next_tutorial")


# PT_BR: Sinal customizado que detecta quando o botão de voltar é pressionado.
# EN_US: Custom signal that detects when the back button is pressed.
func _on_back_button_pressed():
	emit_signal("back_tutorial")
