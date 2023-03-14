extends Node2D


#PT_BR: Função que muda a cena do tutorial, de apresentação, para a próxima cena do tutorial.
#EN_US: Function that changes the apresentation tutorial scene to the next scene of tutorial.
func _on_next_button_pressed():
	get_tree().change_scene("res://scenes/tutorial/FileTutorial.tscn")

#PT_BR: Função que troca a cena do tutorial para a tela de fases .
#EN_US: Function that changes the tutorial scene for the phases screen.
func _on_Skip_button_pressed():
	get_tree().change_scene("res://scenes/Phases.tscn")
