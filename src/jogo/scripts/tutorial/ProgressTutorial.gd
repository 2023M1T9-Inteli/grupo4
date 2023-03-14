extends Node2D

#PT_BR: Função que troca a cena do tutorial para a cena anterior.
#EN_US: Function that changes the tutorial scene with the previus tutorial scene.
func _on_back_button5_pressed():
	get_tree().change_scene("res://scenes/tutorial/Tempo.tscn")
	

#PT_BR: Função que muda do tutorial para a tela de fases do jogo.
#EN_US: Function that changes the tutorial scene for the screen phases.
func _on_start_button5_pressed():
	get_tree().change_scene("res://scenes/Phases.tscn")
