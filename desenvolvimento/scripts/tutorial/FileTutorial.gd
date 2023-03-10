extends Node2D

#PT_BR: Função que troca a cena do tutorial para a cena anterior.
#EN_US: Function that changes the tutorial scene with the previus tutorial scene.
func _on_back_button1_pressed():
	get_tree().change_scene("res://scenes/tutorial/Tutorial.tscn")


#PT_BR: Função que muda a cena do tutorial, de apresentação, para a próxima cena do tutorial.
#EN_US: Function that changes the apresentation tutorial scene to the next scene of tutorial.
func _on_next_button1_pressed():
	get_tree().change_scene("res://scenes/tutorial/TaskTutorial.tscn")
