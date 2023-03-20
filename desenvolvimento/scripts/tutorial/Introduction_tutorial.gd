extends Node2D

var cont = 0
var textos: Array = [
	
	"""Olá! Seja bem-vindo(a) ao tutorial
do jogo O Talento de Delegar.

Para avançar ou voltar, clique nas [color=#3a87ae]setas[/color] ao lado.""",

""

]

func _process(delta):
	if cont == -1:
		get_tree().change_scene("res://scenes/Menu.tscn")
	
	elif cont == 1:
		get_tree().change_scene("res://scenes/tutorial/Skip_button_explanning.tscn")
	
	$text_box/introduction_text.bbcode_text = textos[cont]
	
	
func _on_next_button_pressed():
	cont += 1

func _on_back_button_pressed():
	cont -= 1
