extends Node2D
signal next_tutorial()
signal back_tutorial()
var cont = 0
var textos: Array = [
	
	"""Olá! Seja bem-vindo(a) ao tutorial do jogo O Talento de Delegar.

Para avançar ou voltar, clique nas [color=#3a87ae]setas[/color] ao lado.""",

""

]

func _process(_delta):
	if cont == -1:
		emit_signal("back_tutorial")
	
	elif cont == 1:
		emit_signal("next_tutorial")
	
	$text_box/introduction_text.bbcode_text = textos[cont]
	
	
func _on_next_button_pressed():
	emit_signal("next_tutorial")

func _on_back_button_pressed():
	emit_signal("back_tutorial")
